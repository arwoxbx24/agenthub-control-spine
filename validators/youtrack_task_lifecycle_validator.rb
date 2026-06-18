#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

STAGES = %w[Backlog Develop Review Test Done].freeze
REQUIRED = %w[issue_id run_id duplicate_check implementation_evidence validation_evidence receipt_path blocker].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def validate_case(input)
  missing = REQUIRED.select { |field| blank?(input[field]) }
  return "FULL_TASK_CARD_MISSING" unless missing.empty?
  return "DUPLICATE_CHECK_MISSING" if input["duplicate_check"] == "missing"
  return "ISSUE_STAGE_NOT_DONE" if input["claim_success"] == true && input["final_stage"] != "Done"
  return "BOARD_READBACK_MISMATCH" if input["board_readback"] && input["board_readback"] != input["final_stage"]
  return "BLOCKER_PRESENT" if input["blocker"] != "none"
  return "INVALID_STAGE" unless STAGES.include?(input["final_stage"])

  "PASS"
end

payload = JSON.parse(File.read(ARGV.fetch(0)))
failures = payload.fetch("task_lifecycle_cases").filter_map do |item|
  actual = validate_case(item.fetch("input"))
  expected = item.fetch("expected")
  next if actual == expected

  { "id" => item.fetch("id"), "expected" => expected, "actual" => actual }
end

if failures.empty?
  puts JSON.pretty_generate({ "status" => "PASS", "validator" => File.basename(__FILE__), "cases" => payload.fetch("task_lifecycle_cases").length })
else
  warn JSON.pretty_generate({ "status" => "FAIL", "failures" => failures })
  exit 1
end
