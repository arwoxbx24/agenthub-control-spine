#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("packfix_cases", doc.fetch("cases", []))

ROUTINE_BLOCKERS = [
  "PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID",
  "VALIDATOR_EXECUTION_NOT_RUN",
  "CODEX_USAGE_AUDIT_ACCESS_MISSING",
  "CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED",
  "YOUTRACK_READBACK_PERMISSION_MISSING",
  "T0_DIRECT_AUTHORSHIP_DEFECT",
  "GITHUB_CONNECTOR_WRITE_UNAVAILABLE"
].freeze

def packfix_validate(input)
  same_blocker_count = input.fetch("same_blocker_count", 0).to_i
  block = input.fetch("blocker_type", "").to_s

  return "ROUTE_REPAIR_REQUIRED" if same_blocker_count >= 2 && !block.empty?
  return "OWNER_APPROVAL_REQUIRED" if input.fetch("owner_only", false) == true && input.fetch("owner_approval", false) != true
  return "PACKFIX_REQUIRED" if input.fetch("routine_blocker", false)
  return "PACKFIX_REQUIRED" if input.fetch("usage_audit_missing", false) == true
  return "PACKFIX_REQUIRED" if ROUTINE_BLOCKERS.include?(block)
  return "PACKFIX_REQUIRED" if input.fetch("route_repair_needed", false) == true
  return "BLOCKFIXER_UNKNOWN" if !block.empty? && !ROUTINE_BLOCKERS.include?(block) && block != "NONE"

  "PACKFIX_PASSED"
end

failures = cases.filter_map do |item|
  input = item.fetch("input")
  actual = packfix_validate(input)
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
