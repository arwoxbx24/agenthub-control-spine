#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("truth_cases", doc.fetch("cases", []))

REQUIRED = %w[
  run_id task_id task_class route_lane requested_model resolved_model actual_model
  actual_model_proof_type actual_model_proof_ref usage_window_start usage_window_end
  usage_delta_observed compliance_api_event_ref codex_client_version
  codex_invocation_command_redacted codex_output_artifact_sha256 fallback_used
  fallback_model fallback_reason env_only_model_claim model_truth_status final_state
].freeze

PROOF_TYPES = %w[
  codex_compliance_api codex_usage_page_delta codex_client_session_metadata
  api_response_metadata owner_analytics_readback not_available
].freeze

PROVEN = %w[PROVEN FALLBACK_PROVEN].freeze
PRIMARY = %w[gpt-5.5 main base primary].freeze
M2_ESCALATION_REQUIRED = %w[gpt-5.5].freeze

def proof_required?(status)
  status == "PROVEN" || status == "FALLBACK_PROVEN"
end

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def validate(input)
  missing = REQUIRED.select { |field| !input.key?(field) }
  return "MODEL_EXECUTION_TRUTH_RECEIPT_MISSING_FIELDS" unless missing.empty?
  return "MODEL_EXECUTION_TRUTH_PROOF_TYPE_INVALID" unless PROOF_TYPES.include?(input["actual_model_proof_type"])

  final_state = input.fetch("final_state", "INTERMEDIATE")
  truth_status = input.fetch("model_truth_status")
  proof_ref = input.fetch("actual_model_proof_ref")
  proof_type = input.fetch("actual_model_proof_type")
  code_config = input.fetch("task_class").match?(/code|config|validator|schema|test|fixture|script|workflow|software/i) ||
                input.fetch("route_lane") == "M2"

  if %w[PASS DONE].include?(final_state) && !PROVEN.include?(truth_status)
    return "MODEL_TRUTH_STATUS_BLOCKS_DONE"
  end

  if input.fetch("env_only_model_claim") == true && %w[PASS DONE].include?(final_state)
    return "ENV_ONLY_MODEL_CLAIM_BLOCKED"
  end

  if proof_required?(truth_status)
    return "ACTUAL_MODEL_PROOF_REF_REQUIRED" if blank?(proof_ref)
    return "ACTUAL_MODEL_PROOF_REF_REQUIRED" if proof_type == "not_available"
    return "ACTUAL_MODEL_REQUIRED_FOR_PROVEN_STATUS" if blank?(input["actual_model"])

    return "FALLBACK_USED_FOR_FALLBACK_PROVEN" if truth_status == "FALLBACK_PROVEN" &&
                                                   input.fetch("fallback_used") == false
  end

  if proof_type == "not_available" && proof_required?(truth_status)
    return "MODEL_EXECUTION_PROOF_TYPE_BLOCKED"
  end

  if input.fetch("fallback_used") == true
    return "FALLBACK_REASON_REQUIRED" if blank?(input["fallback_reason"])
    return "FALLBACK_MODEL_REQUIRED" if blank?(input["fallback_model"])
  end

  if code_config &&
     M2_ESCALATION_REQUIRED.include?(input.fetch("resolved_model")) &&
     blank?(input.fetch("model_escalation_receipt", ""))
    return "MODEL_ESCALATION_RECEIPT_REQUIRED"
  end

  if code_config &&
     M2_ESCALATION_REQUIRED.include?(input.fetch("requested_model")) &&
     blank?(input.fetch("model_escalation_receipt", ""))
    return "MODEL_ESCALATION_RECEIPT_REQUIRED"
  end

  "MODEL_EXECUTION_TRUTH_PASS"
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
