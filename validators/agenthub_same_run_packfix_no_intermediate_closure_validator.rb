#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0, "evals/same-run-packfix-no-intermediate-closure/fixtures.json")
doc = JSON.parse(File.read(path))

ROUTINE_BLOCKERS = %w[
  CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED
  YOUTRACK_READBACK_PERMISSION_MISSING
  YOUTRACK_DONE_GATE_REPAIR_REQUIRED
  REGISTER_APPEND_ROUTE_PENDING
  VALIDATOR_EXECUTION_NOT_RUN
  RUNTIME_TOOL_INSTALLATION_REQUIRED
  MODEL_TRUTH_NOT_PROVEN
  PUBLIC_ROUTE_FAILURE
  SECRET_HANDLE_MISSING
  SAME_PROMPT_RESUME_FROM_RESIDUAL_PACKFIX
].freeze

def done_with_evidence?(input)
  input.fetch("implementation_evidence", false) &&
    input.fetch("validation_evidence", false) &&
    input.fetch("receipt", false) &&
    input.fetch("task_graph_done", false) &&
    input.fetch("done_gate", false) &&
    input.fetch("final_output", "").include?("Left: none")
end

def classify(input)
  if input.fetch("terminal_state") == "DENY_FORBIDDEN_SCOPE"
    return input.fetch("forbidden_scope", false) ? "DENY_FORBIDDEN_SCOPE" : "DONE_DENIED"
  end

  if input.fetch("terminal_state") == "OWNER_ONLY_IRREVERSIBLE_GATE"
    return input.fetch("owner_only_probe_complete", false) ? "OWNER_ONLY_IRREVERSIBLE_GATE" : "PACKFIX_REQUIRED"
  end

  blocker = input.fetch("routine_blocker", "")
  if ROUTINE_BLOCKERS.include?(blocker)
    return "PACKFIX_RESUME_REQUIRED" if input.fetch("duplicate_replay", false) && input.fetch("residual_open", false)
    return "PACKFIX_REQUIRED" unless input.fetch("packfix_created", false) && input.fetch("packfix_closed", false)
  end

  return "DONE_WITH_EVIDENCE" if input.fetch("terminal_state") == "DONE_WITH_EVIDENCE" && done_with_evidence?(input)

  "DONE_DENIED"
end

failures = doc.fetch("cases").filter_map do |item|
  actual = classify(item.fetch("input"))
  next if actual == item.fetch("expected")

  { "id" => item.fetch("id"), "expected" => item.fetch("expected"), "actual" => actual }
end

if failures.empty?
  puts JSON.pretty_generate("status" => "PASS", "cases" => doc.fetch("cases").length)
else
  warn JSON.pretty_generate("status" => "FAIL", "failures" => failures)
  exit 1
end
