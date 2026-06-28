#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

REQUIRED_CLASS = %w[TASK_CLASS ROLE ACTIVE_SKILLS FORBIDDEN_SKILLS SCOPE_SIGNATURE NEGATIVE_MATCHES].freeze
ACTIVE_CHILD_STATES = %w[Backlog Develop Review Test].freeze
FAKE_ID = /\b(fake|synthetic|placeholder|todo|tbd|unknown|invented)\b/i

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def pass?(input, key)
  input[key] == true || input[key] == "PASS"
end

def classify(input)
  return "BLOCKED_T0_DIRECT_AUTHORSHIP" if input["actor"] == "T0" && input["mutation_requested"] == true

  if input["terminal_request"] == "Done"
    return "BLOCKED_DONE_EVIDENCE_MISSING" if blank?(input["implementation_evidence"])
    return "BLOCKED_DONE_EVIDENCE_MISSING" if blank?(input["validation_evidence"])
    return "BLOCKED_DONE_EVIDENCE_MISSING" if blank?(input["receipt_path"])
    return "BLOCKED_GITHUB_PR_IS_NOT_DONE" if input["only_github_pr"] == true
    return "BLOCKED_WEAK_PRODUCT_PROOF" if input["only_curl_or_status"] == true
    return "BLOCKED_PARENT_CHILD_DONE_GATE" if Array(input["children"]).any? { |child| ACTIVE_CHILD_STATES.include?(child.fetch("stage", "")) }
    return "BLOCKED_REPORT_AS_DONE" if input["report_only"] == true
    return "SAFETY_QUARANTINE" if [input["task_id"], input["receipt_path"], input["validation_evidence"]].any? { |v| v.to_s.match?(FAKE_ID) }
    return "BLOCKED_DONE_EVIDENCE_MISSING" unless pass?(input, "task_readback_ok") && pass?(input, "register_coverage_ok") && input["blocker_status"] == "NONE" && input["redteam_done_gate"] == "PASS"
  end

  return "BLOCKED_OWNER_CLOSED_UNAUTHORIZED" if input["terminal_request"] == "Owner-Closed" && input["owner_exact_close_command"] != true
  return "PACKFIX_CREATED_NOT_OWNER_STOP" if input["blocker_type"] == "ROUTINE_REMEDIABLE_BLOCKER" && input["owner_chat_stop"] == true
  return "BLOCKED_STALE_ARTIFACT_REPLAY" if %w[audit_only historical_receipt consumed_prompt superseded quarantine].include?(input["artifact_lifecycle"].to_s) && input["loaded_as_active_policy"] == true
  return "MID_CYCLE_PROGRESS_REPORT_BLOCKED" if input["cycle_terminal"] == false && input["user_progress_report"] == true
  return "WRONG_TASK_CLASS_BLOCKER" unless REQUIRED_CLASS.all? { |field| !blank?(input[field]) }

  "DONE_WITH_EVIDENCE"
end

failures = cases.filter_map do |item|
  actual = classify(item.fetch("input"))
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
