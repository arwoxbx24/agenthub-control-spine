#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

GENERIC_MISSING_ACCESS = [
  "blocked",
  "need access",
  "route blocked",
  "missing permissions",
  "AGENTHUB_LIVE_WORKER_ROUTE_REQUIRED"
].freeze

VALID_SPARK_UNAVAILABLE = %w[
  SPARK_CAPABILITY_UNAVAILABLE
  SPARK_QUOTA_EXHAUSTED
  SPARK_AUTH_MISSING
  SPARK_ROUTE_NOT_REGISTERED
].freeze

CODEX_TASKS = %w[CODE_EDIT CONFIG_EDIT YAML_EDIT SHELL_SCRIPT_EDIT PRODUCT_IMPLEMENTATION TEST_EXECUTION].freeze
SPARK_MODEL = "gpt-5.3-codex-spark"
CODEX_FALLBACKS = %w[gpt-5.3-codex gpt-5.1-codex-mini gpt-5.4-mini].freeze

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def missing_access_decision(input)
  required = %w[blocker_type missing_access_surface missing_access_human required_actor required_route why_needed safe_next_action evidence_ref]
  return "MISSING_ACCESS_BLOCKER_SCHEMA_INVALID" if required.any? { |key| blank?(input[key]) }
  return "MISSING_ACCESS_BLOCKER_SCHEMA_INVALID" unless input["blocker_type"] == "MISSING_ACCESS"
  return "MISSING_ACCESS_BLOCKER_SCHEMA_INVALID" if GENERIC_MISSING_ACCESS.include?(input["missing_access_surface"])

  "MISSING_ACCESS_BLOCKER_VALID"
end

def spark_decision(input)
  action = input.fetch("action_class", "")
  model = input.fetch("selected_model", "")
  receipt = input["model_execution_receipt"]
  telemetry = input["usage_delta_or_telemetry_ref"]
  unavailable = input["spark_unavailable_reason"]

  return "T0_DIRECT_ACTION_VIOLATION" if input["actor_role"] == "T0_CONTROL" && CODEX_TASKS.include?(action)
  return "MODEL_ROUTE_NOT_IN_SCOPE" unless CODEX_TASKS.include?(action)

  if model == SPARK_MODEL
    return "CODEX_SPARK_USAGE_PROOF_UNAVAILABLE" if blank?(receipt) && blank?(telemetry)
    return "CODEX_SPARK_RUNTIME_PROOF_PASS" if input["receipt_model_id"] == SPARK_MODEL && !blank?(receipt)

    return "CODEX_SPARK_USAGE_PROOF_UNAVAILABLE"
  end

  if CODEX_FALLBACKS.include?(model)
    return "CODEX_SPARK_ROUTE_NOT_REGISTERED" if blank?(unavailable)
    return "CODEX_SPARK_ROUTE_NOT_REGISTERED" unless VALID_SPARK_UNAVAILABLE.include?(unavailable)
    return "CODEX_SPARK_ROUTE_NOT_REGISTERED" unless input["same_run_fallback"] == true
    return "CODEX_SPARK_ROUTE_NOT_REGISTERED" if blank?(input["spark_unavailable_evidence_ref"])

    return "CODEX_SPARK_UNAVAILABLE_FALLBACK_PASS"
  end

  "CODEX_SPARK_ROUTE_NOT_REGISTERED"
end

def decision(input)
  case input.fetch("case_type")
  when "missing_access"
    missing_access_decision(input)
  when "spark_proof"
    spark_decision(input)
  else
    "WRONG_ROOT_CAUSE_BLOCKER"
  end
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
