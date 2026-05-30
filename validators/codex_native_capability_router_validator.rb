#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

SPARK = "gpt-5.3-codex-spark"
CODEX_FALLBACK = "gpt-5.3-codex"
READONLY_MODELS = %w[gpt-5.4-mini gpt-5.4 deterministic].freeze
RUNTIME_SURFACES = %w[Docker DB proxy firewall DNS PM2 Komodo runtime secrets].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def missing?(input, fields)
  fields.any? { |field| blank?(input[field]) }
end

def overlap?(left, right)
  (Array(left) & Array(right)).any?
end

def route(input)
  common = %w[
    route_class run_id task_id actor_role requested_model resolved_model actual_route
    owner_manual_model_required allowed_surfaces forbidden_surfaces
  ]
  return "CODEX_NATIVE_RECEIPT_MISSING" if missing?(input, common)
  return "OWNER_MANUAL_MODEL_SELECTION_BLOCKED" if input["owner_manual_model_required"] == true
  return "SECRET_OUTPUT_QUARANTINE_REQUIRED" if input["secret_output_detected"] == true

  route_class = input.fetch("route_class")
  role = input.fetch("actor_role")
  requested = input.fetch("requested_model")
  resolved = input.fetch("resolved_model")
  actual = input.fetch("actual_route")

  if role == "T0_CONTROL" && input.fetch("requests_implementation_mutation", false)
    return "T0_CODE_AUTHORSHIP_BLOCKED"
  end

  if input.fetch("runtime_mutation_requested", false)
    authorized = input.fetch("t2_live_worker_authorized", false) &&
                 input.fetch("rollback_evidence", "") == "PASS" &&
                 input.fetch("validation_evidence", "") == "PASS" &&
                 input.fetch("secret_redaction", "") == "PASS"
    return "RUNTIME_SURFACE_AUTHORIZATION_REQUIRED" unless authorized
  end

  if actual == "agenthub-sandbox-worker" && [requested, resolved].include?(SPARK)
    return "SANDBOX_ROUTE_NOT_SPARK_PROOF"
  end

  case route_class
  when "CODEX_EXEC_NONINTERACTIVE_WORKER"
    return "CODEX_EXEC_MODEL_PIN_REQUIRED" unless input["non_interactive"] == true &&
                                                  !blank?(input["profile"]) &&
                                                  requested == resolved &&
                                                  actual == resolved
    return "CODEX_EXEC_NONINTERACTIVE_ALLOWED"

  when "CODEX_SPARK_SPAWN_WORKER"
    required = %w[subagent_id parent_run_id output_artifact_path output_sha256 safety_gate secret_redaction]
    return "SPAWNED_MODEL_RECEIPT_REQUIRED" if missing?(input, required)
    return "SPAWNED_MODEL_MISMATCH_BLOCKED" unless [requested, resolved, actual].all? { |value| value == SPARK }
    return "SPAWNED_ROLE_BLOCKED" unless %w[T2_WORKER T2_CODE_AUTHOR VERIFIER QA READONLY_TRIAGE].include?(role)
    return "SPAWNED_OUTPUT_ARTIFACT_REQUIRED" unless input["output_artifact_exists"] == true
    return "SPAWNED_HASH_REQUIRED" unless input.fetch("output_sha256").match?(/\A[a-f0-9]{64}\z/)
    return "SPAWNED_SAFETY_GATE_REQUIRED" unless input["safety_gate"] == "PASS" && input["secret_redaction"] == "PASS"

    "CODEX_SPARK_SPAWN_WORKER_ALLOWED"

  when "CODEX_SUBAGENT_PARALLEL_READONLY"
    return "PARALLEL_WRITE_CONFLICT_BLOCKED" if input["write_mode"] == true &&
                                                overlap?(input["write_surfaces"], input["other_active_write_surfaces"])
    return "READONLY_SUBAGENT_MODEL_BLOCKED" unless READONLY_MODELS.include?(resolved) && actual == resolved
    return "READONLY_SUBAGENT_WRITE_BLOCKED" unless input["write_mode"] == false

    "CODEX_SUBAGENT_PARALLEL_READONLY_ALLOWED"

  when "CODEX_PROFILED_ROLE_RUN"
    required = %w[profile sandbox permission_profile hooks_bound]
    return "PROFILED_ROLE_BINDING_REQUIRED" if missing?(input, required)
    return "PROFILED_ROLE_RUN_ALLOWED" if input["hooks_bound"] == true

    "PROFILED_ROLE_BINDING_REQUIRED"

  when "CODEX_PERMISSION_GUARDED_RUN"
    danger = input["sandbox"] == "danger-full-access" || input["yolo_mode"] == true
    if danger
      isolated = input["isolated_sandbox_task"] == true && input["receipt_path_exists"] == true
      safe_surface = !overlap?(input["allowed_surfaces"], RUNTIME_SURFACES)
      return "DANGER_FULL_ACCESS_BLOCKED" unless isolated && safe_surface
    end
    return "CODEX_PERMISSION_GUARD_PASS" if input["permission_profile"] && input["sandbox"]

    "PERMISSION_PROFILE_REQUIRED"

  when "CODEX_MCP_DIAGNOSTIC_RUN"
    return "MCP_DIAGNOSTIC_REQUIRED" if input["mcp_dependent_task"] == true &&
                                        input["mcp_diagnostic_receipt"] != "PASS"
    "CODEX_MCP_DIAGNOSTIC_ALLOWED"

  when "CODEX_BACKGROUND_TERMINAL_CONTROL"
    if input["background_runaway_detected"] == true
      return "BACKGROUND_RUNAWAY_REMEDIATION_REQUIRED" unless input["current_session_owned"] == true &&
                                                          input["stop_or_remediation_path"] == "PASS"
    end
    return "BACKGROUND_TERMINAL_CONTROL_ALLOWED" if input["ps_or_equivalent_check"] == "PASS"

    "BACKGROUND_TERMINAL_CHECK_REQUIRED"

  when "CODEX_FEATURE_FLAG_CONTROL"
    return "FEATURE_FLAG_VALIDATOR_COVERAGE_REQUIRED" if input["feature_enable_requested"] == true &&
                                                         input["validator_coverage"] != "PASS"
    return "CODEX_FEATURE_FLAG_CONTROL_ALLOWED" if input["feature_list_receipt"] == "PASS"

    "FEATURE_FLAG_LIST_RECEIPT_REQUIRED"

  when "T2_CODE_FALLBACK"
    allowed = requested == SPARK &&
              resolved == CODEX_FALLBACK &&
              actual == CODEX_FALLBACK &&
              input["same_run_spark_unavailable_proof"] == "PASS" &&
              input["return_to_spark"] == true
    return allowed ? "CODEX_FALLBACK_ALLOWED" : "CODEX_FALLBACK_PROOF_REQUIRED"

  when "DONE_GATE"
    required = %w[
      policy schema validator fixtures spark_spawn_canary readonly_parallel_canary
      mcp_diagnostic_canary background_terminal_canary registers task_readback
    ]
    return "DONE_WITH_CODEX_NATIVE_SPAWN_AND_CLI_GUARDRAILS" if required.all? { |field| input[field] == "PASS" } &&
                                                               input["active_blocker"] == "none"

    "CODEX_NATIVE_DONE_EVIDENCE_MISSING"
  else
    "CODEX_NATIVE_ROUTE_MISSING"
  end
end

failures = cases.filter_map do |item|
  actual = route(item.fetch("input"))
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
