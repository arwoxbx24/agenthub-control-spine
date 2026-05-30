#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

REQUIRED_FIELDS = %w[
  run_id task_id scope_signature actor_role actor_model worker_id action_class
  target_surface allowed_surfaces forbidden_surfaces route_receipt model_route
  secret_redaction evidence_path validation_plan owner_output_mode
].freeze

CODE_ACTIONS = %w[
  CODE_EDIT CONFIG_EDIT YAML_EDIT SHELL_SCRIPT_EDIT FRONTEND_EDIT BACKEND_EDIT
  TEST_EDIT TEST_EXECUTION IAC_EDIT PRODUCT_FILE_WRITE PRODUCT_CONFIG_EDIT
].freeze

RUNTIME_ACTIONS = %w[
  SHELL COMMAND RUNTIME_MUTATE LIVE_ADAPTER_EXECUTE PM2_MUTATE KOMODO_MUTATE
  DOCKER_MUTATE DB_MUTATE PROXY_MUTATE FIREWALL_MUTATE DNS_MUTATE
  MICROSERVICE_MUTATE SERVICE_RESTART
].freeze

T0_FORBIDDEN = (CODE_ACTIONS + RUNTIME_ACTIONS + %w[
  RAW_ENV_DUMP SECRET_READ BROAD_FILESYSTEM_SCAN DIRECT_GIT_MUTATION
]).freeze

BROAD_SURFACES = %w[
  runtime microservice pm2 komodo docker db proxy firewall dns product_repo
  secret_values nginx npm_proxy_manager
].freeze

PRIMARY_CODEX_MODELS = %w[gpt-5.3-codex-spark gpt-5.3-codex].freeze
FALLBACK_CODEX_MODELS = %w[gpt-5.4-mini gpt-5.1-codex-mini].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def missing_required(input)
  REQUIRED_FIELDS.select { |field| blank?(input[field]) }
end

def include_any?(values, denied)
  Array(values).any? { |value| denied.include?(value) }
end

def done_evidence_complete?(input)
  required = %w[
    implementation_evidence validation_evidence receipt_path task_readback
    index_register_coverage pr_lifecycle_state artifact_register_coverage
  ]
  required.all? { |field| input[field] == "PASS" || input[field] == true } &&
    input.fetch("active_blocker", "none") == "none"
end

def decision(input)
  return "ROLE_STATE_REVALIDATION_MISSING" unless missing_required(input).empty?
  return "SECRET_REDACTION_GATE_FAILED" unless input["secret_redaction"] == "PASS"

  if input["run_duplicate"] == true || input.fetch("same_scope_existing_run", false) == true
    return "DUPLICATE_RUN_BLOCKED"
  end

  if input["role_changed_mid_context"] == true && input["reroute_receipt"] != "PASS"
    return "ROLE_STATE_REVALIDATION_MISSING"
  end

  if input["owner_output_mode"] == "PROGRESS_NARRATION" && input["active_run"] == true
    return "OWNER_OUTPUT_SUPPRESSION_REQUIRED"
  end

  if input["owner_request_type"] == "routine_platform_step"
    return "USER_ACTION_LEAK" unless input["same_run_microtask"] == true
  end

  role = input["actor_role"]
  action = input["action_class"]
  surface = input["target_surface"]

  if role == "T0_CONTROL" && (T0_FORBIDDEN.include?(action) || BROAD_SURFACES.include?(surface))
    return RUNTIME_ACTIONS.include?(action) || BROAD_SURFACES.include?(surface) ? "BLOCKED_T0_DIRECT_RUNTIME_ACTION" : "BLOCKED_T0_DIRECT_AUTHORSHIP"
  end

  if CODE_ACTIONS.include?(action)
    return "PRIMARY_MODEL_CODE_AUTHORSHIP_DETECTED" unless role == "T2_CODEX_WORKER"

    model = input["actor_model"]
    return "CODEX_SPARK_CODE_AUTHORING_REQUIRED" unless (PRIMARY_CODEX_MODELS + FALLBACK_CODEX_MODELS).include?(model)

    if model == "gpt-5.3-codex-spark"
      return "ALLOW_CODEX_SPARK_SCOPED_AUTHORING" if input["assigned_scope"] == "PASS"
      return "ROLE_STATE_REVALIDATION_MISSING"
    end

    return "CODEX_SPARK_CODE_AUTHORING_REQUIRED" if input.fetch("spark_selectable", true) == true

    fallback_ok = input["same_run_fallback"] == true &&
                  input["spark_unavailable_evidence"] == "PASS" &&
                  input["fallback_run_id"] == input["run_id"] &&
                  input["assigned_scope"] == "PASS"
    return fallback_ok ? "ALLOW_CODEX_FALLBACK_WITH_SAME_RUN_PROOF" : "CODEX_SPARK_CODE_AUTHORING_REQUIRED"
  end

  if RUNTIME_ACTIONS.include?(action) || BROAD_SURFACES.include?(surface)
    return "LIVE_ADAPTER_AUTHORITY_MISSING" unless role == "T2_DEVOPS_WORKER"

    live_ok = input["live_worker_authorization"] == "PASS" &&
              input["rollback_evidence_path_required"] == true &&
              input["rollback_evidence"] == "PASS" &&
              input["validation_evidence"] == "PASS" &&
              input["exact_task_scope"] == "PASS" &&
              input["no_secret_output"] == "PASS"
    return live_ok ? "ALLOW_T2_LIVE_WORKER_SCOPED_RUNTIME_ACTION" : "LIVE_ADAPTER_AUTHORITY_MISSING"
  end

  if action == "CLOSE_DONE"
    return "SANDBOX_ONLY_NOT_RUNTIME_PROOF" if input["requires_live_runtime"] == true && input["proof_class"] == "sandbox_only"
    return "DISPATCH_NOT_EXECUTION" if input["proof_class"] == "dispatch_only"
    return "DONE_GATE_EVIDENCE_MISSING" if %w[audit_only report_only prompt_only pr_only weak_receipt].include?(input["proof_class"])
    return done_evidence_complete?(input) ? "ALLOW_DONE_WITH_EVIDENCE" : "DONE_GATE_EVIDENCE_MISSING"
  end

  case role
  when "T0_CONTROL"
    %w[CLASSIFY ROUTE VERIFY_RECEIPT FINAL_OWNER_SUMMARY].include?(action) ? "ALLOW_T0_CONTROL_ROUTE" : "BLOCKED_T0_DIRECT_AUTHORSHIP"
  when "T1_ARCHITECT"
    %w[DESIGN_GATE APPROVE_WORKER_CONTRACT ADR].include?(action) ? "ALLOW_T1_ARCHITECTURE" : "ROLE_STATE_REVALIDATION_MISSING"
  when "REGISTRAR"
    %w[UPDATE_INDEX UPDATE_ARTIFACT_REGISTER UPDATE_PR_QUEUE UPDATE_TASK_READBACK WRITE_RECEIPT].include?(action) ? "ALLOW_REGISTRAR_LIFECYCLE" : "FORBIDDEN_SURFACE_BLOCKED"
  when "VERIFIER"
    %w[READ_VALIDATE VERIFY_RECEIPT VALIDATE_EVIDENCE].include?(action) ? "ALLOW_VERIFIER_READONLY" : "FORBIDDEN_SURFACE_BLOCKED"
  else
    "ROLE_STATE_REVALIDATION_MISSING"
  end
end

failures = cases.filter_map do |item|
  actual = decision(item.fetch("input"))
  expected = item.fetch("expected")
  next if actual == expected

  { "id" => item.fetch("id"), "expected" => expected, "actual" => actual }
end

if failures.empty?
  puts JSON.pretty_generate({
    "status" => "PASS",
    "validator" => File.basename(__FILE__),
    "cases" => cases.length
  })
else
  warn JSON.pretty_generate({ "status" => "FAIL", "failures" => failures })
  exit 1
end
