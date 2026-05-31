#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

SPARK = "gpt-5.3-codex-spark"
APPROVED_FINAL_STATES = %w[
  DONE_WITH_EVIDENCE
  READY_BLOCKED_BY_PLATFORM_GATE
  OWNER_ONLY_IRREVERSIBLE_GATE
  FORBIDDEN_SCOPE_BLOCKER
  INSTRUCTION_SOURCE_DRIFT
  WRONG_TASK_CLASS_BLOCKER
  SAFETY_QUARANTINE
].freeze

FORBIDDEN_MUTATION_SURFACES = %w[Docker DB proxy firewall DNS SSL product runtime secrets].freeze

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
  gate = input.fetch("gate")

  case gate
  when "t0_boundary"
    return "BLOCKED_T0_DIRECT_AUTHORSHIP" if input["role"] == "T0_CONTROL" &&
                                             input["mutation_requested"] == true
    return "FORBIDDEN_SCOPE_BLOCKER" if overlap?(input["touched_surfaces"], FORBIDDEN_MUTATION_SURFACES) &&
                                        input["scoped_worker_authority"] != "PASS"
    "T0_BOUNDARY_PASS"

  when "model_actual_proof"
    return "MODEL_ROUTE_ACTUAL_NOT_PROVEN" if missing?(input, %w[requested_model resolved_model actual_model model_proof_ref])
    if input["requested_model"] == SPARK
      return "CODEX_SPARK_ACTUAL_MODEL_NOT_PROVEN" unless input["actual_model"] == SPARK ||
                                                         (input["fallback_approved"] == true &&
                                                          input["same_run_fallback_proof"] == "PASS" &&
                                                          input["return_to_spark"] == true)
    end
    "MODEL_ROUTE_ACTUAL_PROOF_PASS"

  when "spawned_dispatch"
    required = %w[event_id run_id parent_agent_id spawned_agent_id task_id role requested_model resolved_model actual_model model_proof_ref scope_signature prompt_hash evidence_refs no_user_interruption_proof]
    return "SPAWNED_WORKER_RECEIPT_MISSING" if missing?(input, required)
    return "CODEX_SPARK_ACTUAL_MODEL_NOT_PROVEN" if input["requested_model"] == SPARK &&
                                                    input["actual_model"] == "agenthub-sandbox-worker"
    return "SPAWNED_WRITE_CONFLICT" if input["parallel_write"] == true && input["disjoint_worktree"] != true
    "SPAWNED_WORKER_DISPATCH_PASS"

  when "closed_loop"
    return "USER_ACTION_LEAK" if input["owner_interruption"] == true && input["owner_only_gate"] != true
    required = %w[capture duplicate_check task_binding validation tracker_update register_update pr_queue_update final_owner_output]
    return "CLOSED_LOOP_AUTONOMY_PASS" if required.all? { |field| input[field] == "PASS" }
    "CLOSED_LOOP_EVIDENCE_MISSING"

  when "retry_loop"
    return "REPEATED_GATE_LOOP" if input.fetch("same_gate_failures", 0).to_i >= 2 &&
                                   input["architecture_repair_or_typed_blocker"] != true
    return "DUPLICATE_RUN_OR_WORKER_LOOP" if input["duplicate_scope_signature"] == true &&
                                             input["new_evidence_since_last_run"] != true
    "LOOP_CONTROL_PASS"

  when "artifact_lifecycle"
    return "ARTIFACT_LIFECYCLE_DRIFT" if input["artifact_lifecycle"].to_s.match?(/audit_only|consumed|superseded|quarantine/) &&
                                         input["used_as_instruction"] == true
    return "PR_QUEUE_STATE_MISSING" if input["open_pr"] == true && input["pr_queue_state"].to_s.empty?
    return "NO_TASK_READBACK" if input["implementation_closure"] == true && input["task_readback"] != "PASS"
    "LIFECYCLE_AND_QUEUE_PASS"

  when "evidence_quality"
    return "NO_USER_OUTCOME_PROOF" if input["product_claim"] == true && input["user_outcome_proof"] != "PASS"
    return "SECRET_OR_RAW_LINK_RISK" if input["secret_or_raw_link_detected"] == true
    return "MCP_PROOF_REQUIRED" if input["mcp_claim"] == true && input["mcp_tool_receipt"] != "PASS"
    return "SLASH_COMMAND_NOT_BACKEND_PROOF" if input["slash_command_only"] == true
    return "DANGEROUS_CLI_BYPASS_BLOCKED" if input["dangerous_bypass_flag"] == true
    "EVIDENCE_QUALITY_PASS"

  when "hiddify_child"
    return "HIDDIFY_UUID_LINK_NOT_PROVEN" if input["uuid_link_proof"] != "PASS"
    return "HIDDIFY_UUID_LESS_PAYLOAD_LEAK" if input["uuidless_payload"] == true
    return "DOMAIN_HARDCODE_RISK" if input["domain_hardcoded"] == true
    "HIDDIFY_CHILD_GATE_PASS"

  when "done_gate"
    return input["final_state"] if APPROVED_FINAL_STATES.include?(input["final_state"]) &&
                                  input["all_required_evidence"] == "PASS"
    "DONE_GATE_EVIDENCE_MISSING"

  else
    "CLOSED_LOOP_GATE_MISSING"
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
