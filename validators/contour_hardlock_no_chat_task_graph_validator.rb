#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

FINAL_STATES = %w[DONE_WITH_EVIDENCE OWNER_ONLY_IRREVERSIBLE_GATE SAFETY_QUARANTINE].freeze
ACTIVE_STAGES = %w[Backlog Develop Review Test].freeze
TERMINAL_STAGES = %w[Done Blocked Duplicate Superseded Quarantine].freeze
FORBIDDEN_ROOTS = [
  "/root/gemini-space",
  "/root/codex-space",
  "/tmp",
  "/var/lib/docker",
  "/var/lib/mysql",
  "/var/lib/postgresql"
].freeze

FINAL_OUTPUT_PATTERN = /\AFact: .+\nAction: .+\nLeft: (none|[A-Z0-9_]+)\z/
ALLOWED_BLOCKERS = %w[
  OWNER_ONLY_IRREVERSIBLE_GATE
  MISSING_ACCOUNT_CREDENTIAL
  TASK_SERVICE_PHYSICAL_WRITE_MISSING
  PHYSICAL_TASK_WRITE_MISSING
  SPAWN_RECEIPT_MISSING
  MODEL_ROUTE_MISMATCH
  LIVE_PATH_NOT_PROVEN
  FORBIDDEN_PATH_MUTATION
  T0_DIRECT_MUTATION_ATTEMPT
  API_DOCS_FIRST_VIOLATION
  BACKUP_ROLLBACK_MISSING
  DONE_GATE_PARSER_DEFECT
  LOOP_BREAKER_TRIGGERED
  INSTRUCTION_SOURCE_DRIFT
  SECRET_OR_RAW_LINK_RISK
  PR_QUEUE_STATE_MISSING
  ARTIFACT_LIFECYCLE_DEFECT
  USER_OUTCOME_NOT_PROVEN
].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def active_stage?(stage)
  ACTIVE_STAGES.include?(stage.to_s)
end

def terminal_stage?(stage)
  TERMINAL_STAGES.include?(stage.to_s)
end

def forbidden_path?(path)
  FORBIDDEN_ROOTS.any? { |root| path.to_s == root || path.to_s.start_with?("#{root}/") }
end

def outside_allowed?(path, allowed)
  return true if allowed.empty?

  allowed.none? { |root| path.to_s == root.to_s || path.to_s.start_with?("#{root}/") }
end

def route(input)
  case input.fetch("gate")
  when "contour_state_machine"
    return "USER_CHAT_STOP_DEFECT" if input["user_facing_output"] == true &&
                                      !FINAL_STATES.include?(input["state"].to_s)
    return "CONTOUR_STATE_INVALID" unless (FINAL_STATES + %w[
      INTAKE CONTOUR_CREATED TASK_GRAPH_READY ARCHITECTURE_LOCKED
      WORKER_DISPATCHED IMPLEMENTATION_IN_PROGRESS IMPLEMENTATION_EVIDENCE_READY
      QA_IN_PROGRESS QA_PASS TASKS_CLOSING REGISTERS_UPDATED PLATFORM_GATE_BLOCKED
    ]).include?(input["state"].to_s)

    "CONTOUR_STATE_MACHINE_PASS"

  when "task_first_physical_write"
    if input["mutation_requested"] == true &&
       (blank?(input["issue_id"]) || input["task_readback"] != "PASS") &&
       input["typed_blocker"] != "TASK_SERVICE_PHYSICAL_WRITE_MISSING"
      return "TASK_SERVICE_PHYSICAL_WRITE_MISSING"
    end
    "TASK_FIRST_PHYSICAL_WRITE_PASS"

  when "task_graph_stage"
    stages = Array(input["tasks"]).map { |task| task["stage"] }
    return "UNKNOWN_STAGE_IN_TASK_GRAPH" unless stages.all? { |stage| active_stage?(stage) || terminal_stage?(stage) }
    return "PARENT_DONE_CHILD_OPEN" if input["parent_stage"] == "Done" &&
                                      Array(input["children"]).any? { |child| active_stage?(child["stage"]) } &&
                                      input["tracking_parent"] != true
    return "ORPHAN_TASK_IN_CONTOUR" if Array(input["tasks"]).any? { |task| blank?(task["contour_id"]) }
    return "DUPLICATE_TASK_IN_CONTOUR" if input["duplicate_open_issue"] == true

    "TASK_GRAPH_STAGE_PASS"

  when "no_mid_cycle_chat"
    return "USER_CHAT_STOP_DEFECT" if input["contour_open"] == true &&
                                      input["user_facing_output"] == true
    "NO_MID_CYCLE_CHAT_PASS"

  when "message_buffer"
    return "CONTOUR_INPUT_DELTA_MISSING" if input["user_message_received"] == true &&
                                            input["delta_recorded"] != true
    return "USER_CHAT_STOP_DEFECT" if input["worker_stopped"] == true &&
                                      input["delta_class"] != "OWNER_ONLY_GATE"
    "MESSAGE_BUFFER_PASS"

  when "t0_boundary"
    return "T0_DIRECT_MUTATION_ATTEMPT" if input["role"] == "T0_CONTROL" &&
                                           input["mutation_class"].to_s.match?(/code|runtime|docker|db|proxy|firewall|secret|live_config/)
    "T0_BOUNDARY_PASS"

  when "worker_path_scope"
    paths = Array(input["changed_paths"]) + Array(input["evidence_paths"])
    return "FORBIDDEN_PATH_MUTATION" if paths.any? { |path| forbidden_path?(path) } &&
                                        input["explicit_canonical_target"] != true
    return "OUT_OF_SCOPE_MUTATION" if paths.any? { |path| outside_allowed?(path, Array(input["allowed_paths"])) }
    return "LIVE_PATH_NOT_PROVEN" if input["implementation_claim"] == true &&
                                     input["live_path_proof"] != "PASS" &&
                                     input["repo_canonical"] != true
    "WORKER_PATH_SCOPE_PASS"

  when "api_docs_first"
    return "API_DOCS_FIRST_VIOLATION" if input["finished_product"] == true &&
                                         input["direct_internal_mutation"] == true &&
                                         input["official_mechanism_decision"] != "EXHAUSTED_WITH_ADR"
    "API_DOCS_FIRST_PASS"

  when "backup_rollback"
    return "BACKUP_ROLLBACK_MISSING" if input["mutation_requested"] == true &&
                                        input["rollback_proof"] != "PASS"
    return "BACKUP_ROLLBACK_MISSING" if input["backup_size"] == "UNKNOWN_LARGE" &&
                                        input["backup_attempted"] == true
    "BACKUP_ROLLBACK_PASS"

  when "spawn_model_receipt"
    return "SPAWN_RECEIPT_MISSING" if input["spawned_work"] == true &&
                                      (blank?(input["spawn_receipt"]) || input["spawn_receipt"] == "not_applicable")
    return "MODEL_ROUTE_MISMATCH" if input["requested_model"] != input["actual_model"] &&
                                     input["approved_same_run_fallback"] != true
    "SPAWN_MODEL_RECEIPT_PASS"

  when "loop_breaker"
    return "LOOP_BREAKER_TRIGGERED" if input.fetch("same_gate_failures", 0).to_i >= 2 &&
                                      input["third_identical_retry"] == true
    return "LOOP_BREAKER_TRIGGERED" if input.fetch("context_overflows", 0).to_i >= 2 &&
                                      input["full_prompt_replay"] == true
    "LOOP_BREAKER_PASS"

  when "truth_done"
    return "USER_OUTCOME_NOT_PROVEN" if input["product_or_ui_task"] == true &&
                                        input["user_outcome"] != "PASS"
    return "DONE_GATE_PARSER_DEFECT" if input["done_requested"] == true &&
                                       input["validation_state"].to_s.match?(/NOT_PROVEN|PARTIAL|BLOCKED|UNRESOLVED/)
    return "DONE_GATE_PARSER_DEFECT" if input["done_requested"] == true &&
                                       input["task_stage"] != "Done"
    "TRUTH_DONE_PASS"

  when "artifact_pr_security"
    return "ARTIFACT_LIFECYCLE_DEFECT" if input["artifact_changed"] == true &&
                                          input["register_updated"] != true
    return "PR_QUEUE_STATE_MISSING" if input["pr_open"] == true &&
                                       blank?(input["pr_queue_state"])
    return "SECRET_OR_RAW_LINK_RISK" if input["receipt_contains_secret_or_raw_link"] == true
    "ARTIFACT_PR_SECURITY_PASS"

  when "final_output"
    return "FINAL_OUTPUT_POLICY_FAIL" unless input["output"].to_s.match?(FINAL_OUTPUT_PATTERN)
    return "FINAL_OUTPUT_POLICY_FAIL" if input["output"].to_s.lines.length != 3
    "FINAL_OUTPUT_PASS"

  when "contour_done"
    return input["typed_blocker"] if ALLOWED_BLOCKERS.include?(input["typed_blocker"].to_s)
    return "YOUTRACK_CONTOUR_OPEN" unless Array(input["tasks"]).all? { |task| terminal_stage?(task["stage"]) }

    required = %w[
      implementation_evidence validation_evidence agenthub_receipt task_readback
      no_blocker register_index pr_queue no_forbidden_paths security_scan
    ]
    return "DONE_WITH_EVIDENCE" if required.all? { |field| input[field] == "PASS" }

    "DONE_GATE_INCOMPLETE"

  else
    "CONTOUR_HARDLOCK_GATE_MISSING"
  end
end

failures = cases.filter_map do |item|
  actual = route(item.fetch("input"))
  expected = item.fetch("expected")
  next if actual == expected

  { "id" => item.fetch("id"), "expected" => expected, "actual" => actual }
end

if failures.empty?
  puts JSON.pretty_generate({
    "status" => "PASS",
    "cases" => cases.length,
    "validator" => File.basename(__FILE__)
  })
else
  warn JSON.pretty_generate({ "status" => "FAIL", "failures" => failures })
  exit 1
end
