#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

TERMINAL = %w[
  OWNER_ONLY_DESTRUCTIVE_CONFIRMATION_REQUIRED
  BACKUP_OR_REPLACEMENT_PROOF_REQUIRED
  UNKNOWN_PRODUCTION_DATA_RISK
  SECRET_EXPOSURE_RISK
  GLOBAL_INFRASTRUCTURE_AUTHORITY_MISSING
  DUPLICATE_SCOPE_PR_EXISTS
].freeze

SELF_HEAL = {
  "PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID" => "TASK_ID_SELF_HEALING_REQUIRED",
  "DISPATCH_TASK_GATE_MISSING" => "RUN_STATE_SELF_HEALING_REQUIRED",
  "MODEL_FALLBACK_RECEIPT_MISSING" => "MODEL_FALLBACK_RECEIPT_REPAIR_REQUIRED",
  "DUPLICATE_PROGRESS_OUTPUT_BLOCKED" => "PROGRESS_OUTPUT_SUPPRESSED_CONTINUE",
  "FRESH_BRANCH_PROTECTED" => "STATUS_CONTEXT_MAPPING_REPAIR_REQUIRED",
  "T0_DIRECT_AUTHORSHIP_DEFECT" => "CONTROL_SPINE_AUTHORSHIP_CLASSIFICATION_REPAIR_REQUIRED",
  "WORD_FILTER_BLOCKED" => "WORD_FILTER_PAYLOAD_REWRITE_REQUIRED"
}.freeze

def decision(input)
  blocker = input.fetch("blocker")
  attempts = input.fetch("repair_attempts", 0).to_i

  return blocker if TERMINAL.include?(blocker)
  return "TASK_SERVICE_AND_REPO_RECEIPT_BOTH_UNAVAILABLE" if blocker == "TASK_SERVICE_MISSING_ACCESS" && input["repo_fallback_available"] == false
  return "NO_APPROVED_WORKER_ROUTE_AFTER_REPAIR" if blocker == "CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED" && attempts >= 2
  return "ROUTE_TO_READONLY_DIAGNOSTIC_WORKER" if blocker == "CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED" && input["requested_lane"] == 4
  return "ROUTE_TO_REVERSIBLE_REPAIR_WORKER" if blocker == "CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED" && input["requested_lane"] == 5

  mapped = SELF_HEAL[blocker]
  return mapped if mapped && attempts < 2
  return "SAME_GATE_LOOP_LIMIT_REACHED" if mapped && attempts >= 2

  "DONE_WITH_EVIDENCE"
end

failures = cases.filter_map do |item|
  actual = decision(item.fetch("input"))
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
