#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0, "evals/docs-first-validator-route-packfix/fixtures.json")
doc = JSON.parse(File.read(path))
cases = doc.fetch("model_truth_cases", [])

ALLOWED_PROOF_TYPES = %w[
  codex_compliance_api_event
  codex_usage_delta
  codex_client_session_metadata
  codex_cli_json_event_with_model
  codex_remote_app_server_trace
  api_response_metadata
  fallback_model_receipt
  not_available
].freeze

VALID_STATUSES = %w[
  PROVEN
  FALLBACK_PROVEN
  NOT_PROVEN
  BLOCKED_AUDIT_ACCESS
  NO_MODEL_CLAIM
].freeze

def validate(input)
  receipt = input.fetch("model_truth_receipt", {})
  return "MODEL_TRUTH_RECEIPT_MISSING" unless receipt.is_a?(Hash) && !receipt.empty?
  return "MODEL_TRUTH_STATUS_INVALID" unless VALID_STATUSES.include?(receipt.fetch("model_truth_status", ""))

  claim = input.fetch("model_execution_claimed", false)
  status = receipt.fetch("model_truth_status")
  proof_type = receipt.fetch("actual_model_proof_type", "not_available")
  proof_ref = receipt.fetch("actual_model_proof_ref", "")

  return "NO_MODEL_CLAIM_PASS" if claim == false && status == "NO_MODEL_CLAIM"
  return "MODEL_CLAIM_WITH_NO_PROOF" if claim == true && status == "NO_MODEL_CLAIM"
  return "MODEL_PROOF_TYPE_INVALID" unless ALLOWED_PROOF_TYPES.include?(proof_type)
  return "ENV_ONLY_MODEL_PROOF_REJECTED" if receipt.fetch("env_only_model_claim", false) == true && %w[PROVEN FALLBACK_PROVEN].include?(status)
  return "REQUESTED_RESOLVED_ONLY_REJECTED" if %w[requested_model resolved_model env_only].include?(proof_type)

  if %w[PROVEN FALLBACK_PROVEN].include?(status)
    return "MODEL_PROOF_REF_MISSING" if proof_ref.to_s.empty?
    return "MODEL_PROVEN_PASS"
  end

  return "DONE_WITH_UNPROVEN_MODEL_FORBIDDEN" if input.fetch("final_state", "") == "DONE"

  "MODEL_TRUTH_NOT_GREEN"
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
