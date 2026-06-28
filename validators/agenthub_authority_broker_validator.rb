#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("authority_broker_cases", doc.fetch("cases", []))

ALLOWED = [
  "ALLOW",
  "ALLOW_WITH_SCOPED_WORKER",
  "ALLOW_WITH_AUTO_REVIEW",
  "PACKFIX_REQUIRED",
  "OWNER_ONLY_IRREVERSIBLE_GATE",
  "DENY_FORBIDDEN_SCOPE"
].freeze

OWNER_BLOCKERS = [
  "MISSING_ACCOUNT_CREDENTIAL_NO_AGENT_ROUTE",
  "LEGAL_OR_PAYMENT_APPROVAL_REQUIRED",
  "DESTRUCTIVE_PRODUCTION_ACTION_REQUIRES_OWNER_APPROVAL"
].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def validate(input)
  return "AUTHORITY_BROKER_MISSING_FIELDS" if ["run_id", "task_id", "gate_name", "destructive_action", "decision"].any? do |field|
    blank?(input[field]) && field != "destructive_action"
  end

  return "AUTHORITY_BROKER_DECISION_NOT_ALLOWED" unless ALLOWED.include?(input["decision"])

  same_blocker = input.fetch("same_blocker_count", 0)
  return "AUTHORITY_BROKER_ROUTE_REPAIR" if same_blocker.to_i >= 2
  return "DENY_FORBIDDEN_SCOPE" if input["forbidden_scope"] == true
  return "PACKFIX_REQUIRED" if input["routine_blocker"] == true
  return "PACKFIX_REQUIRED" if input["live_worker_missing"] == true
  return "PACKFIX_REQUIRED" if input.fetch("usage_audit_missing", false) == true

  if OWNER_BLOCKERS.include?(input.fetch("owner_blocker", ""))
    return "OWNER_ONLY_IRREVERSIBLE_GATE"
  end

  if input["owner_only"] == true
    return "OWNER_ONLY_IRREVERSIBLE_GATE" unless input.fetch("owner_approval", false) == true
    return "ALLOW_WITH_SCOPED_WORKER"
  end

  return "OWNER_ONLY_IRREVERSIBLE_GATE" if input["destructive_action"] == true && input.fetch("owner_approval", false) != true

  return "DENY_FORBIDDEN_SCOPE" if input.fetch("generic_block", false) == true
  "ALLOW"
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
