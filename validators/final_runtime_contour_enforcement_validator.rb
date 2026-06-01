#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

FORBIDDEN_ROOTS = %w[
  /root/gemini-space
  /root/codex-space
  /tmp
  /var/lib/docker
  /var/lib/mysql
  /var/lib/postgresql
].freeze

ACTIVE_STAGES = %w[Backlog Develop Review Test].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def forbidden_path?(path)
  FORBIDDEN_ROOTS.any? { |root| path.to_s == root || path.to_s.start_with?("#{root}/") }
end

def pass?(input, key)
  input[key] == "PASS"
end

def route(input)
  case input.fetch("gate")
  when "forbidden_path_pretool"
    return "FORBIDDEN_PATH_MUTATION" if Array(input["paths"]).any? { |path| forbidden_path?(path) }
    return "LIVE_PATH_NOT_PROVEN" if input["product_implementation"] == true && input["live_path_proof"] != "PASS"

    "FORBIDDEN_PATH_PRETOOL_PASS"

  when "silent_until_terminal"
    return "MID_CYCLE_USER_CHAT_BLOCKED" if input["contour_open"] == true &&
                                            input["terminal_state"] != true &&
                                            input["user_facing_output"] == true

    "SILENT_UNTIL_TERMINAL_PASS"

  when "user_delta_queue"
    return "USER_DELTA_QUEUE_MISSING" if input["user_message_received"] == true && input["delta_recorded"] != true
    return "USER_CHAT_STOP_DEFECT" if input["worker_stopped"] == true &&
                                      input["delta_class"] != "OWNER_ONLY_IRREVERSIBLE_GATE"

    "USER_DELTA_QUEUE_PASS"

  when "model_spawn_receipt"
    return "SPAWN_RECEIPT_MISSING" if input["spawned_implementation"] == true &&
                                      (blank?(input["spawn_receipt"]) || input["spawn_receipt"] == "not_applicable")
    return "MODEL_ROUTE_MISMATCH" if input["requested_model"] != input["actual_model"] &&
                                     input["approved_same_run_fallback"] != true

    "MODEL_SPAWN_RECEIPT_PASS"

  when "done_gate_parser"
    full_evidence = %w[implementation_evidence validation_evidence receipt no_blocker].all? { |field| pass?(input, field) }
    return "DONE_GATE_PARSER_DEFECT" if full_evidence && input["parser_result"] == "REJECT"
    return "DONE_GATE_INCOMPLETE" unless full_evidence

    "DONE_GATE_PARSER_PASS"

  when "anti_spam_not_freeze"
    return "DUPLICATE_TASK_BLOCKED_EXISTING_WORK_ALLOWED" if input["duplicate_master_exists"] == true &&
                                                             input["new_task_create_requested"] == true &&
                                                             input["existing_task_stage_update"] == true
    return "BROAD_FREEZE_DEFECT" if input["existing_task_stage_update"] == false &&
                                    input["duplicate_master_exists"] == true

    "ANTI_SPAM_NOT_FREEZE_PASS"

  when "task_graph"
    return "PARENT_DONE_CHILD_OPEN" if input["parent_stage"] == "Done" &&
                                      Array(input["children"]).any? { |child| ACTIVE_STAGES.include?(child["stage"].to_s) }

    "TASK_GRAPH_PASS"

  when "context_budget_loop_breaker"
    return "LOOP_BREAKER_TRIGGERED" if input.fetch("same_gate_failures", 0).to_i >= 2 && input["third_attempt"] == true
    return "LOOP_BREAKER_TRIGGERED" if input.fetch("context_overflows", 0).to_i >= 2 && input["full_prompt_replay"] == true

    "CONTEXT_BUDGET_LOOP_BREAKER_PASS"

  when "final_contour_done"
    required = %w[
      implementation_evidence validation_evidence agenthub_receipt youtrack_readback
      register_index pr_queue user_outcome no_blocker no_forbidden_zone security_scan
    ]
    return "DONE_WITH_EVIDENCE" if required.all? { |field| pass?(input, field) }

    "DONE_GATE_INCOMPLETE"

  else
    "FINAL_RUNTIME_CONTOUR_GATE_MISSING"
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

