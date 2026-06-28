#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("model_router_truth_cases", doc.fetch("cases", []))

SPARK = "gpt-5.3-codex-spark"
ACCEPTED_PROOF = %w[
  codex_compliance_api_event
  codex_usage_delta
  codex_client_session_metadata
  codex_cli_json_event_with_model
  codex_remote_app_server_trace
  api_response_metadata
  fallback_model_receipt
].freeze
CODE_HINT = /code|config|validator|schema|fixture|test|workflow/i.freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def validate(input)
  return "MODEL_ROUTER_TRUTH_MISSING_FIELDS" if ["run_id", "task_id", "requested_model", "resolved_model", "actual_model", "actual_model_proof_type", "actual_model_proof_ref", "task_class", "route_lane"].any? { |k| blank?(input[k]) }

  proof_type = input.fetch("actual_model_proof_type")
  return "MODEL_TRUTH_PROOF_NOT_ACCEPTED" unless ACCEPTED_PROOF.include?(proof_type) || proof_type == "not_available"

  if input.fetch("env_only_model_claim", false)
    return "ENV_ONLY_MODEL_CLAIM_FAILS"
  end

  code_task = CODE_HINT.match?(input.fetch("task_class", ""))

  if code_task && input.fetch("first_attempt_model") == SPARK
    # okay
  elsif code_task
    return "CODEX_SPARK_FIRST_REQUIRED"
  end

  if code_task && input.fetch("actual_model") == "gpt-5.5" && blank?(input.fetch("model_escalation_receipt", ""))
    return "MODEL_ESCALATION_RECEIPT_REQUIRED"
  end

  if input.fetch("final_state", "") == "DONE" || input.fetch("final_state", "") == "PASS"
    return "MODEL_TRUTH_MISSING_PACKFIX" if input.fetch("usage_audit_access", true) == false
    return "MODEL_TRUTH_PROOF_MISSING" if proof_type == "not_available" || blank?(input.fetch("actual_model_proof_ref", ""))
    return "PACKFIX_REQUIRED" unless input.fetch("model_truth_status", "") == "PROVEN"
  end

  "MODEL_ROUTER_TRUTH_PASS"
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
