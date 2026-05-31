#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

SPARK = "gpt-5.3-codex-spark"
CODEX_FALLBACKS = %w[gpt-5.3-codex gpt-5.4-mini gpt-5.4].freeze
CODE_TASKS = %w[code config yaml shell backend frontend test iac].freeze
APPROVED_PROFILES = %w[T0_CONTROL T1_ARCHITECT T2_CODEX_SPARK_WORKER VERIFIER REGISTRAR].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def missing?(input, fields)
  fields.any? { |field| blank?(input[field]) }
end

def uuid_link?(value)
  value.to_s.match?(%r{/client/[0-9a-fA-F-]{32,36}(/|$)})
end

def route(input)
  component = input.fetch("component")

  case component
  when "model_routing"
    return "T0_CODE_AUTHORSHIP_BLOCKED" if input["actor_role"] == "T0_CONTROL" && input["task_surface"].to_s.match?(/code|config|yaml|shell|backend|frontend|test|iac/)
    return "PRIMARY_MODEL_CODE_AUTHORSHIP_BLOCKED" if CODE_TASKS.include?(input["task_surface"]) && %w[gpt-5.5 main base primary].include?(input["actual_model"])
    return "SANDBOX_ROUTE_NOT_SPARK_PROOF" if input["requested_model"] == SPARK && input["actual_route"] == "agenthub-sandbox-worker"

    if CODE_TASKS.include?(input["task_surface"]) && input.fetch("spark_available", true)
      return "CODEX_SPARK_ROUTE_PASS" if input["requested_model"] == SPARK && input["resolved_model"] == SPARK && input["actual_route"] == SPARK
      return "CODEX_SPARK_ROUTE_REQUIRED"
    end

    if input["spark_available"] == false
      fallback_ok = input["requested_model"] == SPARK &&
                    CODEX_FALLBACKS.include?(input["resolved_model"]) &&
                    input["same_run_spark_unavailable_proof"] == "PASS" &&
                    input["return_to_spark"] == true
      return fallback_ok ? "CODEX_FALLBACK_PASS" : "CODEX_FALLBACK_PROOF_REQUIRED"
    end

    "MODEL_ROUTE_MISSING"

  when "native_spawn"
    return "T0_CODE_AUTHORSHIP_BLOCKED" if input["actor_role"] == "T0_CONTROL" && input["requests_mutation"] == true
    required = %w[spawned_id task_id run_id requested_model resolved_model actual_route output_artifact_path output_sha256]
    return "SPAWN_ROUTE_CONTRACT_REQUIRED" if missing?(input, required)
    return "SPAWNED_FORBIDDEN_SURFACE_BLOCKED" if Array(input["touched_surfaces"]).any? { |surface| %w[DB secrets UUID runtime].include?(surface) }
    return "SPAWNED_OUTPUT_HASH_REQUIRED" unless input["output_sha256"].to_s.match?(/\A[a-f0-9]{64}\z/)
    return "SANDBOX_ROUTE_NOT_SPARK_PROOF" if input["requested_model"] == SPARK && input["actual_route"] == "agenthub-sandbox-worker"
    return "SPARK_SPAWN_PASS" if input["requested_model"] == SPARK && input["resolved_model"] == SPARK && input["actual_route"] == SPARK
    return "READONLY_PARALLEL_PASS" if input["read_only"] == true && input["mutation"] == false

    "SPAWN_ROUTE_CONTRACT_REQUIRED"

  when "cli_profile"
    return "UNKNOWN_PROFILE_BLOCKED" unless APPROVED_PROFILES.include?(input["profile"])
    return "DANGER_FULL_ACCESS_BLOCKED" if input["sandbox"] == "danger-full-access" && input["isolated_authorized_sandbox"] != true

    case input["profile"]
    when "T0_CONTROL"
      return input["sandbox"] == "read-only" && input["can_write"] == false ? "CLI_T0_PROFILE_PASS" : "CLI_PROFILE_POLICY_MISMATCH"
    when "T1_ARCHITECT"
      return input["can_runtime_mutate"] == false ? "CLI_T1_PROFILE_PASS" : "CLI_PROFILE_POLICY_MISMATCH"
    when "T2_CODEX_SPARK_WORKER"
      return input["requested_model"] == SPARK && input["sandbox"] == "workspace-write" ? "CLI_T2_SPARK_PROFILE_PASS" : "CLI_PROFILE_POLICY_MISMATCH"
    when "VERIFIER"
      return input["read_only"] == true && input["can_write"] == false ? "CLI_VERIFIER_PROFILE_PASS" : "CLI_PROFILE_POLICY_MISMATCH"
    when "REGISTRAR"
      return input["register_only"] == true ? "CLI_REGISTRAR_PROFILE_PASS" : "CLI_PROFILE_POLICY_MISMATCH"
    end

  when "continuous_loop"
    return "OWNER_OUTPUT_SUPPRESSION_GATE_MISSING" if input["mid_run_owner_output"] == true
    return "OWNER_ROUTINE_CLICK_BLOCKED" if input["owner_routine_click_required"] == true
    return "SAME_GATE_SELF_HEALING_REQUIRED" if input.fetch("same_gate_failures", 0).to_i >= 2 && input["self_healing_task_created"] != true
    return "PARENT_DONE_WITH_OPEN_CHILD_BLOCKED" if input["parent_done"] == true && input["open_child_tasks"].to_i.positive? && input["tracking_parent_allowed"] != true

    required = %w[request_capture task_link worker_spawn validation tracker_update final_owner_output]
    return "HIDDEN_CONTINUOUS_LOOP_PASS" if required.all? { |field| input[field] == "PASS" } && input["mid_run_owner_output"] == false

    "CONTINUOUS_LOOP_EVIDENCE_MISSING"

  when "hiddify_flow"
    return "HIDDIFY_CANONICAL_PATH_REQUIRED" if input["canonical_real_project_path"] != "PASS"
    return "HIDDIFY_BROWSER_VALIDATION_FAILED" if input["browser_validation"] != "PASS"
    return "HIDDIFY_UUID_LINK_FLOW_NOT_FIXED" unless uuid_link?(input["user_link_shape"])
    return "HIDDIFY_UUID_LINK_FLOW_NOT_FIXED" if input["uuidless_client_payload"] == true
    return "HIDDIFY_FORBIDDEN_MUTATION_BLOCKED" if input["db_mutation"] == true || input["secret_output"] == true || input["uuid_regeneration"] == true

    "HIDDIFY_UUID_LINK_FLOW_PASS"

  when "done_gate"
    required = %w[repo_baseline native_spawn cli_profile continuous_loop hiddify_acceptance registers tracker_readback secret_scan]
    return "DONE_WITH_EVIDENCE" if required.all? { |field| input[field] == "PASS" } && input["active_blocker"] == "none"
    return input["active_blocker"] if %w[
      CODEX_NATIVE_SPAWN_ROUTE_NOT_INSTALLED
      CODEX_SPARK_ACTUAL_MODEL_NOT_PROVEN
      CLI_PROFILE_ROUTER_NOT_INSTALLED
      OWNER_OUTPUT_SUPPRESSION_GATE_MISSING
      HIDDIFY_UUID_LINK_FLOW_NOT_FIXED
      HIDDIFY_BROWSER_VALIDATION_FAILED
      LIVE_ADAPTER_AUTHORITY_GATE_REQUIRED
      TRACKER_MUTATION_ROUTE_BLOCKED
      REGISTER_READBACK_MISSING
      SAFETY_QUARANTINE
    ].include?(input["active_blocker"])

    "DONE_GATE_EVIDENCE_MISSING"
  else
    "THREE_COMPONENT_ROUTE_MISSING"
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
