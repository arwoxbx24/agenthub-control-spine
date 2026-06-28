#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("youtack_done_model_truth_cases", doc.fetch("cases", []))

def validate(input)
  return "YOUTRACK_DONE_CASE_MISSING_FIELDS" if ["run_id", "task_id", "final_state", "done_intent"].any? do |field|
    input[field].nil?
  end

  return "YOUTRACK_DONE_NOT_FINAL" unless input.fetch("done_intent", false)
  return "YOUTRACK_DONE_NOT_BLOCKED_FINAL" unless input.fetch("final_state") == "DONE"
  return "YOUTRACK_DONE_PROMPT_DUMP_BLOCKED" if input.fetch("prompt_dump_only", false)
  return "YOUTRACK_DONE_OWNER_BLOCKED" if input.fetch("owner_only", false) && input.fetch("owner_approval", false) != true
  return "YOUTRACK_DONE_MODEL_PROOF_MISSING" if input.fetch("model_truth_required", false) &&
                                               !input.fetch("model_proof_available", false)
  return "YOUTRACK_DONE_MODEL_PROOF_MISSING" if input.fetch("usage_audit_access", true) == false
  "YOUTRACK_DONE_PASSED"
end

failures = cases.filter_map do |item|
  input = item.fetch("input")
  actual = validate(input)
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
