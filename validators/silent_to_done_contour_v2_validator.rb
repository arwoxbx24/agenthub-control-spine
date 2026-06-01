#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

INTAKE_STATE = "INTAKE"
TERMINAL_OUTPUT_STATES = %w[DONE_WITH_EVIDENCE OWNER_ONLY_IRREVERSIBLE_GATE SAFETY_QUARANTINE].freeze
MID_CONTOUR_STATES = %w[
  CONTOUR_CREATED TASK_GRAPH_READY ARCHITECTURE_LOCKED WORKER_DISPATCHED
  IMPLEMENTATION_IN_PROGRESS IMPLEMENTATION_EVIDENCE_READY QA_IN_PROGRESS
  QA_PASS TASKS_CLOSING REGISTERS_UPDATED PLATFORM_GATE_BLOCKED
  FORBIDDEN_SCOPE_BLOCKER
].freeze
FORBIDDEN_OUTPUT_PHRASES = /(Принял|Продолжаю|Жду|Сейчас|Worker вернул PASS|Осталось|Blocked|Left)/i
FORBIDDEN_PATHS = %w[/root/gemini-space /root/codex-space /tmp].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def forbidden_path?(path)
  FORBIDDEN_PATHS.any? { |root| path.to_s == root || path.to_s.start_with?("#{root}/") }
end

def route(input)
  case input.fetch("gate")
  when "silent_output_state"
    return "INTAKE_QUESTION_LIMIT_EXCEEDED" if input["state"] == INTAKE_STATE &&
                                               input.fetch("questions_asked", 0).to_i > 3
    if MID_CONTOUR_STATES.include?(input["state"].to_s) && input["user_output"] == true
      return "MID_CYCLE_USER_CHAT_BLOCKED"
    end
    if input["state"].to_s == "FORBIDDEN_SCOPE_BLOCKER" &&
       input["owner_only_irreversible"] != true &&
       input["user_output"] == true
      return "MID_CYCLE_USER_CHAT_BLOCKED"
    end
    return "USER_OUTPUT_STATE_PASS" if input["state"] == INTAKE_STATE || TERMINAL_OUTPUT_STATES.include?(input["state"].to_s)

    "USER_OUTPUT_STATE_PASS"

  when "forbidden_phrase"
    return "MID_CYCLE_USER_CHAT_BLOCKED" if input["contour_open"] == true &&
                                            input["message"].to_s.match?(FORBIDDEN_OUTPUT_PHRASES)
    "FORBIDDEN_PHRASE_PASS"

  when "message_buffer"
    if input["user_message_received"] == true
      required = %w[timestamp normalized_intent severity modifies_scope owner_only_irreversible affected_tasks]
      return "CONTOUR_MESSAGE_BUFFER_MISSING" if required.any? { |key| !input.key?(key) }
      return "OWNER_ONLY_IRREVERSIBLE_GATE" if input["owner_only_irreversible"] == true
      return "MID_CYCLE_USER_CHAT_BLOCKED" if input["answered_user"] == true
    end
    "MESSAGE_BUFFER_PASS"

  when "task_service_circuit_breaker"
    return "TASK_SERVICE_PHYSICAL_WRITE_REPAIR_REQUIRED" if input["physical_write_failed"] == true &&
                                                            input.fetch("same_failure_count", 0).to_i >= 2 &&
                                                            input["local_ledger_created"] == true
    return "TASK_SERVICE_RETRY_LOOP_BLOCKED" if input["physical_write_failed"] == true &&
                                                input.fetch("same_failure_count", 0).to_i > 2
    "TASK_SERVICE_CIRCUIT_BREAKER_PASS"

  when "path_authority"
    paths = Array(input["changed_paths"]) + Array(input["evidence_paths"])
    return "FORBIDDEN_PATH_MUTATION" if paths.any? { |path| forbidden_path?(path) }
    required = %w[active_root_proof allowed_write_paths forbidden_paths rollback_proof validation_path]
    return "PATH_AUTHORITY_MISSING" if input["write_requested"] == true &&
                                       required.any? { |key| blank?(input[key]) }
    "PATH_AUTHORITY_PASS"

  when "model_spawn_receipt"
    return "SPAWN_RECEIPT_MISSING" if input["spawned_work"] == true &&
                                      (blank?(input["spawn_receipt"]) || input["spawn_receipt"] == "not_applicable")
    return "MODEL_ROUTE_MISMATCH" if input["requested_model"] != input["actual_model"] &&
                                     input["approved_same_run_fallback"] != true
    return "QA_CANNOT_SUBSTITUTE_IMPLEMENTATION" if input["role"] == "QA" &&
                                                   input["counts_as_implementation"] == true
    "MODEL_SPAWN_RECEIPT_PASS"

  when "retry_budget"
    return "TOKEN_BLOAT_DEFECT" if input["full_chat_history_in_worker_prompt"] == true
    return "RETRY_CIRCUIT_BREAKER_TRIGGERED" if input.fetch("same_gate_failures", 0).to_i >= 2 &&
                                               input["third_attempt"] == true
    "RETRY_BUDGET_PASS"

  when "done_gate"
    return "DONE_BLOCKED_TASK_SERVICE_REPAIR_REQUIRED" if input["task_service_blocker"] == "TASK_SERVICE_PHYSICAL_WRITE_REPAIR_REQUIRED" &&
                                                          input["task_service_is_active_defect"] != true
    return "DONE_BLOCKED_NOT_PROVEN" if %w[NOT_PROVEN BLOCKED_RESTART_REQUIRED PARTIAL].include?(input["validation_state"])
    return "DONE_BLOCKED_FORBIDDEN_PATH" if Array(input["evidence_paths"]).any? { |path| forbidden_path?(path) }
    return "DONE_BLOCKED_MODEL_ROUTE" if input["model_route_gate"] != "PASS"
    required = %w[
      master_task_readback child_tasks_terminal implementation_evidence qa_evidence
      security_scan path_authority model_spawn_receipt agenthub_receipt
      register_pr_queue no_active_blocker
    ]
    return "DONE_WITH_EVIDENCE" if required.all? { |key| input[key] == "PASS" }
    "DONE_GATE_INCOMPLETE"

  else
    "SILENT_TO_DONE_V2_GATE_MISSING"
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
