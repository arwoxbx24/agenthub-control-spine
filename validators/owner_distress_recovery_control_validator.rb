#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

DISTRESS_PATTERN = /site broken|client screaming|production broken|you destroyed the site|panic|karau|караул|клиент.*крич|сайт.*слом|прод.*слом/i
PROD_RISK_BRANCHES = %w[main master].freeze
ACTIVE_TAIL_STATES = %w[open active review develop test].freeze
EXACT_OWNER_PROD_PHRASES = [
  "разрешаю отгрузку на прод",
  "разрешаю точечный rollback"
].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def pass?(input, key)
  input[key] == true || input[key] == "PASS"
end

def owner_prod_phrase?(value)
  EXACT_OWNER_PROD_PHRASES.any? { |phrase| value.to_s.downcase.include?(phrase) }
end

def classify_environment(input)
  return "PROD_RISK" if input["product_repository"] == true && PROD_RISK_BRANCHES.include?(input["branch"].to_s)
  return "PROD_RISK" if input["product_repository"] == true && input["workflow_action"].to_s.match?(/\b(run|watch|dispatch)\b/i) && input["environment_proof"] != "PASS"
  return "PROD_RISK" if input["remote_ambiguity"] == true && input["product_repository"] == true
  return "TEST_CONFIRMED" if input["environment_proof"] == "PASS" && input["test_only"] == true && input["production_side_effect_excluded"] == true
  return "LOCAL_ONLY" if input["local_only"] == true
  return "PRODUCTION" if input["production"] == true && input["environment_proof"] == "PASS"

  "UNKNOWN_ENVIRONMENT"
end

def route(input)
  distress = input["owner_message"].to_s.match?(DISTRESS_PATTERN)

  return "DIRECT_GH_WORKFLOW_OUTSIDE_AGENTHUB_BLOCKED" if input["gate"] == "github_workflow" &&
                                                           input["workflow_action"].to_s.match?(/\b(run|watch|dispatch)\b/i) &&
                                                           input["authorized_agenthub_route"] != true

  env = classify_environment(input)

  return "OWNER_DISTRESS_SIGNAL_MISSING" if input["gate"] == "owner_distress_signal" && distress != true
  return "INCIDENT_PROFILE_REQUIRED" if distress && input["incident_profile"] != "INCIDENT"
  return "NO_APOLOGY_RESULT_LOOP_BLOCKED" if distress && input["agent_reply"].to_s.match?(/\bI stop\b|остановлюсь|извин|sorry|apolog/i) && input["read_only_triage_started"] != true
  return "READ_ONLY_STATE_CAPTURE_REQUIRED" if distress && input["rollback_requested"] == true && input["read_only_state_capture"] != "PASS"
  return "READ_ONLY_TRIAGE_STARTED" if distress && input["read_only_triage_started"] == true && input["task_bound"] == true && input["run_bound"] == true

  return "PROD_RISK_ENVIRONMENT_PROOF_REQUIRED" if env == "PROD_RISK" && input["operation_requested"] == true
  return "PROD_RISK_ENVIRONMENT_PROOF_REQUIRED" if env == "UNKNOWN_ENVIRONMENT" && input["operation_requested"] == true
  return "TEST_VALIDATION_ALLOWED" if env == "TEST_CONFIRMED" && input["operation"] == "test_validation"

  if %w[prod_deploy rollback prod_mutation].include?(input["operation"].to_s)
    return "OWNER_PROD_PHRASE_REQUIRED" unless owner_prod_phrase?(input["owner_phrase"])
    required = %w[task_id run_id rollback_checkpoint_plan impact_analysis].none? { |key| blank?(input[key]) }
    return "RECOVERY_ACTION_AUTHORIZED" if required && pass?(input, "environment_target_proof") && input["authorized_worker_route"] == true

    return "RECOVERY_AUTHORIZATION_INCOMPLETE"
  end

  return "OWNER_ONLY_IRREVERSIBLE_GATE" if input["operation"] == "irreversible_recovery" &&
                                           input["forbidden_surface"] == true &&
                                           input["owner_only_gate_message"].to_s.lines.count <= 1

  if input["terminal_request"] == "Done"
    tails = Array(input["open_tails"]).any? { |tail| ACTIVE_TAIL_STATES.include?(tail.to_s.downcase) }
    return "ANTI_CHAOS_TAIL_CLOSURE_REQUIRED" if tails || input["pr_queue_updated"] != true || input["artifact_register_updated"] != true || input["index_updated"] != true
    return "CLIENT_CLAIM_LEDGER_REQUIRED" if input["client_claim"] == true && input["claim_ledger"] != "GREEN"
    return "DONE_WITH_EVIDENCE" if pass?(input, "implementation_evidence") && pass?(input, "validation_evidence") && pass?(input, "receipt")

    return "DONE_EVIDENCE_REQUIRED"
  end

  "OWNER_DISTRESS_RECOVERY_CONTROL_PASS"
end

failures = cases.filter_map do |item|
  actual = route(item.fetch("input"))
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
