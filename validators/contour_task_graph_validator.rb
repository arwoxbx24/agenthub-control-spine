#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

ACTIVE_STAGES = %w[Backlog Develop Review Test].freeze
TERMINAL_STAGES = %w[Done Blocked Duplicate Superseded Quarantine].freeze
FORBIDDEN_PATH_PREFIXES = [
  "/root/gemini-space",
  "/root/codex-space",
  "/tmp",
  "/var/lib/docker"
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
  FORBIDDEN_PATH_PREFIXES.any? do |prefix|
    path.to_s == prefix || path.to_s.start_with?("#{prefix}/")
  end
end

def outside_allowed?(path, allowed_paths)
  return true if allowed_paths.empty?

  allowed_paths.none? do |prefix|
    path.to_s == prefix.to_s || path.to_s.start_with?("#{prefix}/")
  end
end

def route(input)
  case input.fetch("gate")
  when "parent_child_done"
    open_child = Array(input["children"]).find { |child| active_stage?(child["stage"]) }
    return "PARENT_DONE_CHILD_OPEN" if input["parent_stage"] == "Done" && open_child
    return "UNKNOWN_STAGE_IN_TASK_GRAPH" unless ([input["parent_stage"]] + Array(input["children"]).map { |c| c["stage"] }).all? { |stage| active_stage?(stage) || terminal_stage?(stage) }

    "PARENT_CHILD_DONE_GATE_PASS"

  when "no_fake_done_when_youtrack_open"
    if input["done_requested"] == true &&
       input["agenthub_merge"] == "SUCCESS" &&
       Array(input["tasks"]).any? { |task| active_stage?(task["stage"]) }
      return "YOUTRACK_CONTOUR_OPEN"
    end
    "NO_FAKE_DONE_WHEN_YOUTRACK_OPEN_PASS"

  when "task_service_physical_write"
    missing_issue = blank?(input["issue_id"]) || input["task_readback"] == false
    blocked_status = %w[NOOP non_actionable PHYSICAL_TASK_WRITE_MISSING].include?(input["task_service_status"])
    return "TASK_SERVICE_PHYSICAL_WRITE_MISSING" if (input["mutation_requested"] == true || input["done_requested"] == true) &&
                                                     (missing_issue || blocked_status)

    "TASK_SERVICE_PHYSICAL_WRITE_PASS"

  when "worker_scope_allowlist"
    changed_paths = Array(input["changed_paths"])
    allowed_paths = Array(input["allowed_paths"])
    return "FORBIDDEN_SCOPE_TOUCH" if changed_paths.any? { |path| forbidden_path?(path) }
    return "OUT_OF_SCOPE_MUTATION" if changed_paths.any? { |path| outside_allowed?(path, allowed_paths) }

    "WORKER_SCOPE_ALLOWLIST_PASS"

  when "message_buffer_delta"
    return "CONTOUR_INPUT_DELTA_MISSING" if input["user_message_received"] == true &&
                                            input["delta_recorded"] != true
    return "USER_CHAT_STOP_DEFECT" if input["worker_stopped"] == true &&
                                      input["delta_classification"] != "OWNER_ONLY_GATE"

    "CONTOUR_INPUT_DELTA_PASS"

  when "task_explosion_guard"
    return "DUPLICATE_TASK_CREATION_BLOCKED" if input["duplicate_open_issue"] == true &&
                                                input["created_new_issue"] == true
    return "TASK_EXPLOSION_REQUIRES_T1_DECISION" if input.fetch("active_child_count", 0).to_i > 7 &&
                                                    input["t1_split_decision"] != true

    "TASK_EXPLOSION_GUARD_PASS"

  when "same_gate_retry_limit"
    return "DEADLOCK_RETRY_LIMIT_REACHED" if input.fetch("same_gate_failures", 0).to_i >= 2 &&
                                             input["third_identical_retry"] == true

    "SAME_GATE_RETRY_LIMIT_PASS"

  when "t0_boundary"
    return "BLOCKED_T0_DIRECT_MUTATION" if input["role"] == "T0_CONTROL" &&
                                           input["code_mutation"] == true

    "T0_BOUNDARY_PASS"

  when "qa_implementation_substitution"
    return "QA_ONLY_PROOF_NOT_IMPLEMENTATION" if input["done_requested"] == true &&
                                                 input["implementation_evidence"] != "PASS" &&
                                                 input["qa_evidence"] == "PASS"

    "QA_IMPLEMENTATION_SUBSTITUTION_PASS"

  when "contour_done"
    return "YOUTRACK_CONTOUR_OPEN" unless Array(input["tasks"]).all? { |task| terminal_stage?(task["stage"]) }
    return "IMPLEMENTATION_EVIDENCE_MISSING" if Array(input["tasks"]).any? { |task| task["stage"] == "Done" && task["implementation_evidence"] != "PASS" }
    return "VALIDATION_EVIDENCE_MISSING" if Array(input["tasks"]).any? { |task| task["validation_evidence"] != "PASS" }
    return "TASK_READBACK_MISSING" if Array(input["tasks"]).any? { |task| task["task_readback"] != "PASS" }
    return "AGENTHUB_RECEIPT_MISSING" unless input["agenthub_receipt"] == "PASS"
    return "ORPHAN_TASK_IN_CONTOUR" unless input["no_orphans"] == true
    return "DUPLICATE_TASK_IN_CONTOUR" unless input["no_duplicates"] == true
    return "FORBIDDEN_SCOPE_TOUCH" unless input["no_forbidden_paths"] == true
    return "REGISTER_OR_PR_EVIDENCE_MISSING" unless input["register_pr_evidence"] == "PASS"

    "DONE_WITH_EVIDENCE"

  else
    "CONTOUR_TASK_GRAPH_GATE_MISSING"
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
