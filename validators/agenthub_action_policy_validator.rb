#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

T0_DENIED = %w[
  SHELL COMMAND DOCKER DOCKER_COMPOSE PYTHON BASH NODE PHP RUBY GO YC TWC NPM
  GIT_MUTATION PRODUCT_FILE_WRITE PRODUCT_CONFIG_EDIT PRODUCT_TEST_EXECUTION
  SECRET_ENV_DUMP SECRET_READ DATABASE NPM_PROXY_MANAGER DNS_SSL FIREWALL
  APP_RUNTIME BROAD_FILESYSTEM_SCAN
].freeze

ROLE_PROFILE = {
  "T0_CONTROL" => "T0_CONTROL_ONLY",
  "T1_ARCHITECT" => "T1_ARCHITECT",
  "T2_CODEX_IMPLEMENTER" => "T2_CODEX_IMPLEMENTER",
  "P4_RUNTIME_READ" => "P4_RUNTIME_READ",
  "P4_RUNTIME_REPAIR" => "P4_RUNTIME_REPAIR",
  "SECRET_HANDLE_READER" => "SECRET_HANDLE_READER",
  "VERIFIER_READONLY" => "VERIFIER_READONLY",
  "REGISTRAR" => "REGISTRAR"
}.freeze

OWNER_ONLY = %w[
  EXTERNAL_CREDENTIAL_REQUIRED LEGAL_AUTHORITY_REQUIRED PAYMENT_AUTHORITY_REQUIRED
  OWNER_ONLY_DESTRUCTIVE_DELETE_GATE NON_DELEGABLE_IDENTITY_PROOF_REQUIRED
  SECRET_HANDLE_MISSING
].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def decision(input)
  required = %w[
    run_id task_id actor_role authority_profile action_class scope_signature
    evidence_path receipt_path
  ]
  return "ROLE_AUTHORITY_MISSING" if required.any? { |key| blank?(input[key]) }
  return "BLOCK_MISSING_ALLOWED_SURFACES" if blank?(input["allowed_surfaces"])
  return "BLOCK_MISSING_FORBIDDEN_SURFACES" if blank?(input["forbidden_surfaces"])
  return "MODEL_ROUTE_EVIDENCE_MISSING" if !input.key?("fallback_reason") || blank?(input["worker_model"]) || blank?(input["model_route_reason"])

  return "SAME_GATE_LOOP_BLOCKED" if input.fetch("same_gate_failures", 0).to_i >= 2

  owner_gate = input.fetch("owner_only_gate", "none")
  return owner_gate if OWNER_ONLY.include?(owner_gate)

  role = input.fetch("actor_role")
  profile = input.fetch("authority_profile")
  action = input.fetch("action_class")

  return "BLOCKED_T0_DIRECT_AUTHORSHIP" if role == "T0_CONTROL" && T0_DENIED.include?(action)
  return "ROLE_AUTHORITY_MISSING" unless ROLE_PROFILE[role] == profile

  case profile
  when "T0_CONTROL_ONLY"
    %w[CLASSIFY ROUTE VERIFY_RECEIPT FINAL_OWNER_SUMMARY].include?(action) ? "ALLOW_WITH_RECEIPT" : "BLOCKED_T0_DIRECT_AUTHORSHIP"
  when "T1_ARCHITECT"
    %w[ADR METHOD_SELECTION RISK_REVIEW MICRO_TZ].include?(action) ? "ALLOW_WITH_RECEIPT" : "INTERNAL_CAPABILITY_REMEDIATION_REQUIRED"
  when "T2_CODEX_IMPLEMENTER"
    return "CODEX_CAPABLE_MODEL_REQUIRED" unless input.fetch("model_class", "") == "CODEX_CAPABLE"
    codex_primary_models = %w[gpt-5.3-codex-spark gpt-5.3-codex]
    codex_fallback_models = %w[gpt-5.1-codex-mini gpt-5.4-mini]
    model = input.fetch("worker_model", "")
    mutation_actions = %w[CODE_EDIT CONFIG_EDIT YAML_EDIT SHELL_SCRIPT_EDIT TEST_EXECUTION IAC_EDIT]

    return "BLOCK_NON_CODEX_MODEL_FOR_CODE_MUTATION" unless (codex_primary_models + codex_fallback_models).include?(model)
    return "FALLBACK_REASON_FORBIDDEN_ON_PRIMARY_ROUTE" if codex_primary_models.include?(model) && !input.fetch("fallback_reason").nil?

    if codex_fallback_models.include?(model)
      fallback_model = input["fallback_model"]
      primary_unavailable = input["codex_available"] == false || input["primary_route_unavailable"] == true
      evidence_ref = input["primary_attempt_evidence_ref"] || input["codex_unavailable_evidence_ref"]
      same_run = input["same_run_fallback"] == true

      return "BLOCK_FALLBACK_REASON_ONLY" if blank?(input.fetch("fallback_reason")) || blank?(fallback_model) || !primary_unavailable || blank?(evidence_ref) || !same_run
      return "BLOCK_NON_CODEX_MODEL_FOR_CODE_MUTATION" unless codex_fallback_models.include?(fallback_model)
      return "BLOCK_FALLBACK_DIFFERENT_RUN" unless input["fallback_run_id"] == input["run_id"]

      return mutation_actions.include?(action) ? "ALLOW_SAME_RUN_FALLBACK_WITH_PRIMARY_UNAVAILABLE_EVIDENCE" : "INTERNAL_CAPABILITY_REMEDIATION_REQUIRED"
    end

    mutation_actions.include?(action) ? "ALLOW_CODEX_PRIMARY_WITH_SURFACE_EVIDENCE" : "INTERNAL_CAPABILITY_REMEDIATION_REQUIRED"
  when "P4_RUNTIME_READ"
    %w[RUNTIME_READ DOCKER_READ NPM_READ DNS_READ YC_READ TWC_READ LOG_SUMMARY CURL_READ].include?(action) ? "ALLOW_WITH_RECEIPT" : "INTERNAL_CAPABILITY_REMEDIATION_REQUIRED"
  when "P4_RUNTIME_REPAIR"
    %w[SCOPED_RUNTIME_REPAIR SCOPED_DOCKER_RESTART SCOPED_PM2_RESTART SCOPED_SYSTEMD_RESTART].include?(action) ? "ALLOW_WITH_ROLLBACK_AND_RECEIPT" : "INTERNAL_CAPABILITY_REMEDIATION_REQUIRED"
  when "SECRET_HANDLE_READER"
    action == "SECRET_HANDLE_LOOKUP" ? "ALLOW_METADATA_ONLY" : "SECRET_REDACTION_REQUIRED"
  when "VERIFIER_READONLY"
    %w[VALIDATE_REPO VALIDATE_TASK VALIDATE_RUNTIME_EVIDENCE VALIDATE_USER_OUTCOME].include?(action) ? "ALLOW_READONLY" : "INTERNAL_CAPABILITY_REMEDIATION_REQUIRED"
  when "REGISTRAR"
    %w[REGISTER_ARTIFACT UPDATE_INDEX UPDATE_PR_QUEUE UPDATE_LIFECYCLE_TASK_READBACK].include?(action) ? "ALLOW_WITH_RECEIPT" : "INTERNAL_CAPABILITY_REMEDIATION_REQUIRED"
  else
    "INTERNAL_CAPABILITY_REMEDIATION_REQUIRED"
  end
end

failures = cases.filter_map do |item|
  actual = decision(item.fetch("input"))
  expected = item.fetch("expected")
  next if actual == expected

  { "id" => item.fetch("id"), "expected" => expected, "actual" => actual }
end

if failures.empty?
  puts JSON.pretty_generate({ "status" => "PASS", "cases" => cases.length, "validator" => File.basename(__FILE__) })
else
  warn JSON.pretty_generate({ "status" => "FAIL", "failures" => failures })
  exit 1
end
