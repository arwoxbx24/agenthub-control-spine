#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0, "evals/docs-first-validator-route-packfix/fixtures.json")
doc = JSON.parse(File.read(path))
cases = doc.fetch("validator_route_cases", [])

ALLOWED_DECISIONS = %w[
  ALLOW
  ALLOW_WITH_SCOPED_WORKER
  ALLOW_WITH_AUTO_REVIEW
  PACKFIX_REQUIRED
  ROUTE_REPAIR_REQUIRED
  OWNER_ONLY_IRREVERSIBLE_GATE
  DENY_FORBIDDEN_SCOPE
].freeze

ROUTINE_BLOCKERS = %w[
  PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID
  DISPATCH_TASK_GATE_MISSING
  YOUTRACK_READBACK_PERMISSION_MISSING
  CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED
  VALIDATOR_EXECUTION_NOT_RUN
  MODEL_FALLBACK_RECEIPT_MISSING
  CODEX_USAGE_AUDIT_ACCESS_MISSING
  LIVE_WORKER_AUTHORITY_MISSING_AFTER_PACKFIX
  PUBLIC_ROUTE_FAILURE
  DUPLICATE_PROGRESS_OUTPUT_BLOCKED
  T0_DIRECT_AUTHORSHIP_DEFECT
  T0_DIRECT_RUNTIME_MUTATION_DEFECT
  GITHUB_CONNECTOR_WRITE_UNAVAILABLE
].freeze

REQUIRED_FIELDS = %w[
  run_id
  task_id
  lane
  validator_name
  validator_path
  execution_route
  allowed_commands
  redaction_gate
  readback_ref
  decision
].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def validate(input)
  return "AUTHORITY_ENVELOPE_MISSING" unless input["authority_envelope"].is_a?(Hash)

  env = input.fetch("authority_envelope")
  missing = REQUIRED_FIELDS.any? { |field| blank?(env[field]) }
  return "AUTHORITY_ENVELOPE_MISSING_FIELDS" if missing
  return "GENERIC_BLOCK_DECISION_FORBIDDEN" if env.fetch("decision") == "BLOCK"
  return "AUTHORITY_DECISION_INVALID" unless ALLOWED_DECISIONS.include?(env.fetch("decision"))
  return "VALIDATOR_LANE_INVALID" unless env.fetch("lane").to_i == 3
  return "VALIDATOR_ROUTE_NOT_TASK_BOUND" unless env.fetch("run_id") == input.fetch("run_id") && env.fetch("task_id") == input.fetch("task_id")
  return "SECRET_REDACTION_GATE_FAIL" unless env.fetch("redaction_gate") == "PASS"
  return "T0_SHELL_PROOF_REJECTED" if env.fetch("execution_route") == "t0_direct_shell" && input.fetch("final_state", "") == "DONE"

  blocker = input.fetch("blocker_type", "NONE")
  same_count = input.fetch("same_blocker_count", 0).to_i
  if ROUTINE_BLOCKERS.include?(blocker)
    return "THIRD_SAME_GATE_RETRY_FORBIDDEN" if same_count >= 3
    return "ROUTE_REPAIR_REQUIRED" if same_count >= 2
    return "PACKFIX_REQUIRED" unless %w[PACKFIX_REQUIRED ROUTE_REPAIR_REQUIRED].include?(env.fetch("decision"))
  end

  if input.fetch("final_state", "") == "DONE"
    return "VALIDATOR_EXECUTION_NOT_RUN" unless input.fetch("validator_executed", false) == true
    return "VALIDATOR_EXIT_NONZERO" unless input.fetch("validator_exit_code", 1).to_i.zero?
  end

  "VALIDATOR_ROUTE_PASS"
end

failures = cases.filter_map do |item|
  actual = validate(item.fetch("input"))
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
