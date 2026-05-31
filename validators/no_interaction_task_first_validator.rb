#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

USER_TEXT_STATES = %w[
  INTAKE_CAPTURE
  DONE_WITH_EVIDENCE
  OWNER_ONLY_IRREVERSIBLE_GATE
  SAFETY_QUARANTINE
  EXPLICIT_USER_STOP_OR_ROLLBACK
  READY_BLOCKED_BY_PLATFORM_GATE
  FORBIDDEN_SCOPE_BLOCKER
  INSTRUCTION_SOURCE_DRIFT
].freeze

ACTIVE_STATES = %w[
  TASK_BOOTSTRAP
  TECHNICAL_ASSIGNMENT
  ACTIVE_RUN
  INTERNAL_BLOCKER_REMEDIATION
  VALIDATION
  FINAL_AGGREGATION
].freeze

FORBIDDEN_SURFACES = %w[DB Docker proxy firewall DNS SSL runtime product secrets].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def missing?(input, fields)
  fields.any? { |field| blank?(input[field]) }
end

def intersects?(left, right)
  (Array(left) & Array(right)).any?
end

def route(input)
  case input.fetch("gate")
  when "task_first"
    return "TASK_FIRST_REMEDIATION_REQUIRED" if input["task_exists"] != true
    return "DUPLICATE_TASK_REJECTED" if input["duplicate_create_attempt"] == true
    return "TASK_FIRST_GATE_PASS" if input["duplicate_check"] == "PASS" &&
                                     input["scope_signature"].to_s != "" &&
                                     input["acceptance_gates"] == "PASS" &&
                                     input["rollback_plan"] == "PASS" &&
                                     input["forbidden_zones_declared"] == true

    "TASK_FIRST_GATE_INCOMPLETE"

  when "technical_assignment"
    required = %w[
      problem_statement business_outcome system_boundaries affected_components
      role_matrix selected_skills source_of_truth execution_order
      rollback_checkpoint validation_matrix security_validation
      acceptance_gates evidence_format final_format
    ]
    return "TECHNICAL_ASSIGNMENT_REQUIRED" if input["mutation_requested"] == true && input["assignment_exists"] != true
    return "TECHNICAL_ASSIGNMENT_INCOMPLETE" if input["assignment_exists"] == true && missing?(input, required)

    "TECHNICAL_ASSIGNMENT_PASS"

  when "communication_state"
    return "NO_MID_CYCLE_USER_CHAT_BLOCKED" if ACTIVE_STATES.include?(input["state"]) &&
                                              input["user_facing_output"] == true
    return "USER_OUTPUT_POLICY_FAIL" if input["final_state"] == "DONE_WITH_EVIDENCE" &&
                                        input["final_format"] != "Fact/Action/Left"
    return "COMMUNICATION_STATE_PASS" if USER_TEXT_STATES.include?(input["state"]) ||
                                         ACTIVE_STATES.include?(input["state"])

    "UNKNOWN_COMMUNICATION_STATE"

  when "user_input_queue"
    return "RUN_USER_INPUT_QUEUE_REQUIRED" if input["state"] == "ACTIVE_RUN" &&
                                             input["user_message_received"] == true &&
                                             input["queue_event_written"] != true
    return "SCOPE_REINFORCEMENT_QUEUED" if input["classification"] == "SCOPE_REINFORCEMENT" &&
                                          input["user_reply_allowed"] == false &&
                                          input["worker_continues"] == true
    return "EXPLICIT_USER_STOP_OR_ROLLBACK" if %w[EMERGENCY_STOP ROLLBACK_REQUEST].include?(input["classification"]) &&
                                               input["mutation_stopped"] == true
    return "UNRELATED_REQUEST_DEFERRED" if input["classification"] == "NEW_UNRELATED_REQUEST" &&
                                           input["backlog_or_defer"] == true &&
                                           input["current_run_continues"] == true

    "RUN_USER_INPUT_QUEUE_PASS"

  when "parent_child_done"
    return "PARENT_DONE_WITH_OPEN_CHILD_REJECTED" if input["parent_done"] == true &&
                                                     input.fetch("open_children", 0).to_i.positive? &&
                                                     input["parent_tracking_only"] != true
    return "CHILD_DONE_WITHOUT_EVIDENCE_REJECTED" if input["child_done"] == true &&
                                                     input["child_evidence"] != "PASS"
    "PARENT_CHILD_DONE_PASS"

  when "worker_aggregation"
    return "MODEL_ROUTE_MISMATCH" if input["requested_model"] &&
                                     input["actual_model"] &&
                                     input["requested_model"] != input["actual_model"] &&
                                     input["fallback_approved"] != true
    return "INDEPENDENT_VERIFICATION_REQUIRED" if input["worker_output"] == "partial_patch" &&
                                                  input["independent_verification"] != "PASS"
    return "SUBAGENT_RECEIPT_INCOMPLETE" if input["spawned"] == true &&
                                            missing?(input, %w[task_id run_id role requested_model resolved_model actual_model scope_signature evidence_ref])

    "WORKER_AGGREGATION_PASS"

  when "evidence_done"
    return "NO_USER_OUTCOME_PROOF" if input["product_claim"] == true && input["user_outcome_proof"] != "PASS"
    return "DONE_REJECTED_MISSING_TASK_READBACK" if input["report_written"] == true && input["task_readback"] != "PASS"
    return "ARTIFACT_LIFECYCLE_DRIFT" if input["old_report_lifecycle"].to_s.match?(/audit_only|consumed|superseded|quarantine/) &&
                                         input["used_as_instruction"] == true
    return "PLATFORM_REMEDIATION_REQUIRED" if input["routine_blocker"] == true &&
                                              input["user_interruption"] == false &&
                                              input["remediation_task_or_queue_state"] == true
    return "OWNER_ONLY_IRREVERSIBLE_GATE" if input["owner_credential_missing"] == true &&
                                             input["safe_autonomous_route"] != true
    return "FORBIDDEN_SCOPE_BLOCKER" if intersects?(input["requested_surfaces"], FORBIDDEN_SURFACES) &&
                                        input["scoped_authority"] != true
    return "FRONTEND_USER_OUTCOME_REQUIRED" if input["frontend_task"] == true &&
                                               input["browser_or_screenshot_validation"] != "PASS"

    "EVIDENCE_DONE_PASS"

  when "done_gate"
    required = %w[
      task duplicate_check technical_assignment no_mid_cycle_chat user_input_queue
      parent_child_done subagent_model_proof routine_blocker_remediation
      artifact_lifecycle pr_queue validators secret_scan task_readback receipt
    ]
    return "DONE_WITH_EVIDENCE" if required.all? { |field| input[field] == "PASS" } &&
                                   input["active_blocker"] == "none"
    return input["active_blocker"] if %w[
      OWNER_ONLY_IRREVERSIBLE_GATE SAFETY_QUARANTINE EXPLICIT_USER_STOP_OR_ROLLBACK
      FORBIDDEN_SCOPE_BLOCKER INSTRUCTION_SOURCE_DRIFT READY_BLOCKED_BY_PLATFORM_GATE
    ].include?(input["active_blocker"])

    "DONE_GATE_EVIDENCE_MISSING"

  else
    "NO_INTERACTION_TASK_FIRST_GATE_MISSING"
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
