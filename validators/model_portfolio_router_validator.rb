#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

CODE_CLASSES = %w[
  code config yaml shell test frontend backend iac
].freeze

SPARK = "gpt-5.3-codex-spark"
CODEX_FALLBACK = %w[gpt-5.3-codex gpt-5.4-mini gpt-5.4].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def required_missing?(input, fields)
  fields.any? { |field| blank?(input[field]) }
end

def route(input)
  common = %w[run_id task_id route_class task_class worker_role requested_model resolved_model actual_route owner_manual_model_required]
  return "MODEL_PORTFOLIO_RECEIPT_MISSING" if required_missing?(input, common)
  return "OWNER_MANUAL_MODEL_SELECTION_BLOCKED" if input["owner_manual_model_required"] == true

  route_class = input.fetch("route_class")
  task_class = input.fetch("task_class")
  requested = input.fetch("requested_model")
  resolved = input.fetch("resolved_model")
  actual = input.fetch("actual_route")

  if CODE_CLASSES.include?(task_class)
    return "T0_CODE_AUTHORSHIP_BLOCKED" if input["worker_role"] == "T0_CONTROL"
    return "T1_IMPLEMENTATION_MUTATION_BLOCKED" if input["worker_role"] == "T1_ARCHITECT"
    return "CODEX_SPARK_ROUTE_REQUIRED" unless input["worker_role"] == "T2_CODEX_IMPLEMENTER"
    return "SANDBOX_ROUTE_NOT_SPARK_PROOF" if actual == "agenthub-sandbox-worker"

    if input.fetch("spark_available", true) == true
      return "CODEX_SPARK_ROUTE_REQUIRED" unless requested == SPARK && resolved == SPARK && actual == SPARK
      return "CODEX_SPARK_CANARY_PASS" if input["code_artifact_path_exists"] == true

      return "CODE_ARTIFACT_MISSING"
    end

    fallback_ok = CODEX_FALLBACK.include?(resolved) &&
                  actual == resolved &&
                  input["same_run_fallback_proof"] == "PASS" &&
                  !blank?(input["fallback_reason"]) &&
                  input["return_to_spark_when_available"] == true
    return fallback_ok ? "CODEX_FALLBACK_CANARY_PASS" : "CODEX_FALLBACK_PROOF_REQUIRED"
  end

  case route_class
  when "T0_PREGATEWAY"
    return "T0_ROUTE_PASS" if input["worker_role"] == "T0_CONTROL" && %w[gpt-5.5 gpt-5.4].include?(resolved)
  when "T1_ARCHITECT"
    return "T1_ROUTE_PASS" if input["worker_role"] == "T1_ARCHITECT" && %w[gpt-5.4 gpt-5.5].include?(resolved)
  when "TASK_SERVICE"
    return "TASK_SERVICE_ROUTE_PASS" if input["worker_role"] == "TASK_SERVICE" && %w[deterministic gpt-5.4-mini gpt-5.2].include?(resolved)
  when "VERIFIER"
    return "VERIFIER_ROUTE_PASS" if input["worker_role"] == "VERIFIER" && %w[deterministic gpt-5.4-mini gpt-5.4].include?(resolved)
  when "RESEARCH"
    return "RESEARCH_ROUTE_PASS" if input["worker_role"] == "RESEARCH" && %w[tool_search gpt-5.4-mini gpt-5.4].include?(resolved) && requested != SPARK
  when "SECURITY_REDACTION"
    return "SECURITY_ROUTE_PASS" if input["worker_role"] == "SECURITY" && %w[deterministic gpt-5.4-mini].include?(resolved)
  when "CONTINUOUS_TASK_LOOP"
    required = %w[
      request_capture duplicate_check task_creation microtask_execution
      stage_movement evidence_attachment validation done_gate final_output
    ]
    return "CONTINUOUS_LOOP_PASS" if required.all? { |field| input[field] == "PASS" } &&
                                     input["owner_progress_readback"] == false
    return "CONTINUOUS_LOOP_PROOF_REQUIRED"
  when "DONE_GATE"
    done_required = %w[
      model_portfolio_installed continuous_loop_installed t0_escape_gate_installed
      spark_canary fallback_canary validators registers task_readback pr_finalized
    ]
    return "DONE_WITH_MODEL_PORTFOLIO_AND_CONTINUOUS_LOOP_EVIDENCE" if done_required.all? { |field| input[field] == "PASS" } &&
                                                                       input["active_blocker"] == "none"
    return "DONE_GATE_EVIDENCE_MISSING"
  end

  "MODEL_PORTFOLIO_ROUTE_MISSING"
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
