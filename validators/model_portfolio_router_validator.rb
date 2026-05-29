#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("routes")

PRIMARY_MODELS = %w[gpt-5.5 main base primary].freeze
CODEX_MODELS = %w[gpt-5.3-codex-spark gpt-5.3-codex gpt-5.1-codex-mini gpt-5.4-mini].freeze
VALID_ROUTE_CLASSES = %w[
  CONTROL_T0 ARCHITECT_T1 CODEX_PRIMARY_T2 CODEX_FALLBACK_T2 REGISTRAR
  VERIFIER_QA SECURITY_REDACTION BROWSER_PRODUCT_QA DEVOPS_RUNTIME
].freeze
VALID_CANARY_STATES = %w[
  active_task_proof canary_proof MODEL_ROUTE_IDLE_NO_ELIGIBLE_TASKS typed_unavailable
].freeze

def present?(value)
  !value.nil? && value.to_s.strip != ""
end

def code_surface?(input)
  input.fetch("code_config_surface", false) ||
    input.fetch("task_surface", "").to_s.match?(/\b(code|config|yaml|shell|frontend|backend|test|iac|programming)\b/i)
end

def route(input)
  return "SELF_HEALING_ESCALATION" if input.fetch("same_gate_failures", 0).to_i >= 2
  return "MODEL_ROUTE_CLASS_MISSING" unless VALID_ROUTE_CLASSES.include?(input.fetch("route_class", ""))
  return "MODEL_ROUTE_CANARY_UNAVAILABLE" unless VALID_CANARY_STATES.include?(input.fetch("canary_status", ""))
  return "STALE_PR_QUEUE_RECONCILIATION_REQUIRED" if input.fetch("open_pr_queue_state", "none") == "missing"
  return "STALE_ARTIFACT_REPLAY_FORBIDDEN" if input.fetch("artifact_lifecycle_status", "") == "consumed_prompt" &&
                                               input.fetch("proof_source", "") == "stale_prompt"

  actor_role = input.fetch("actor_role", "")
  actor_model = input.fetch("actor_model", "")

  if code_surface?(input)
    return "T0_DIRECT_CODE_AUTHORSHIP_DETECTED" if actor_role == "T0_CONTROL" && input.fetch("requests_code_or_command", false)
    return "PRIMARY_MODEL_CODE_AUTHORSHIP_DETECTED" if PRIMARY_MODELS.include?(actor_model)
  end

  return "VERIFIER_MUTATION_FORBIDDEN" if input.fetch("route_class") == "VERIFIER_QA" && input.fetch("attempts_mutation", false)

  case input.fetch("route_class")
  when "CODEX_PRIMARY_T2"
    return "CODEX_SPARK_ROUTE_REQUIRED" unless CODEX_MODELS.include?(actor_model)
    if input.fetch("proof_source", "") == "codex_cli_json_usage_receipt"
      return "CODEX_SPARK_EXECUTION_NOT_PROVEN" unless input.fetch("requested_model", "") == "gpt-5.3-codex-spark"
      return "CODEX_SPARK_EXECUTION_NOT_PROVEN" unless input.fetch("usage_input_tokens", 0).to_i.positive? &&
                                                    input.fetch("usage_output_tokens", 0).to_i.positive?
      return "CODEX_SPARK_ROUTE_NOT_EXECUTED" if input.fetch("fallback_used", false)
    end
  when "CODEX_FALLBACK_T2"
    return "CODEX_SPARK_ROUTE_NOT_EXECUTED" unless CODEX_MODELS.include?(actor_model)
    return "FALLBACK_WITHOUT_SPARK_UNAVAILABILITY_PROOF" unless present?(input.fetch("same_run_unavailability_proof", ""))
  when "SECURITY_REDACTION"
    return "SECURITY_SCANNER_FIRST_REQUIRED" unless input.fetch("deterministic_scanner_first", false)
  when "ARCHITECT_T1"
    return "BOUNDED_SOURCE_PACKET_REQUIRED" unless input.fetch("bounded_source_packet", false)
  end

  if input.fetch("route_state", "") == "unavailable"
    return "MODEL_ROUTE_UNAVAILABLE_BLOCKER_MISSING" unless present?(input.fetch("residual_blocker", ""))
  end

  "MODEL_ROUTE_CLASSIFIED"
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
