#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("route_cases", doc.fetch("cases", []))

REQUIRED = %w[
  run_id task_id task_class route_lane spark_catalog_visible first_attempt_model
  requested_model resolved_model fallback_used fallback_model fallback_reason
  model_escalation_receipt
].freeze

SPARK = "gpt-5.3-codex-spark"
M2_ALLOWED_FALLBACKS = %w[gpt-5.3-codex gpt-5.4-mini gpt-5.4 gpt-5.5].freeze
PRIME_MODELS = %w[gpt-5.5 main base primary].freeze
WORKLOAD_CLASSES = %w[code config validator schema test fixture script workflow software].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def code_workload?(task_class)
  WORKLOAD_CLASSES.any? { |keyword| task_class.match?(/#{keyword}/i) }
end

def workload_ratio_exceeded?(input)
  total = input.fetch("m0_count_total", 0).to_f
  routine = input.fetch("m0_count_routine", 0).to_f
  return false if total <= 0
  (routine / total) > 0.05
end

def validate(input)
  missing = REQUIRED.select { |field| !input.key?(field) }
  return "MODEL_ROUTE_DECISION_MISSING_FIELDS" unless missing.empty?

  lane = input.fetch("route_lane")
  route_surface_is_code = lane == "M2" || code_workload?(input.fetch("task_class"))

  if lane == "M0"
    return "M0_ROUTINE_CLASSIFICATION_MISSING" if input.fetch("is_routine_workload", nil).nil?
    if input["is_routine_workload"] == true &&
       !input.key?("route_workload_context") &&
       !input.key?("m0_workload_total")
      return "M0_ROUTINE_WORKLOAD_CONTEXT_MISSING"
    end
    return "M0_ROUTINE_METRIC_MISSING" if input["is_routine_workload"] == true &&
      (input["m0_count_total"].nil? || input["m0_count_routine"].nil?)
    if input["is_routine_workload"] == true &&
       workload_ratio_exceeded?(input) &&
       blank?(input.fetch("model_escalation_receipt", ""))
      return "M0_ROUTINE_BUDGET_EXCEEDED_WITHOUT_ESCALATION"
    end
  end

  if route_surface_is_code
    if input.fetch("spark_catalog_visible") == true &&
       input.fetch("first_attempt_model") != SPARK
      return "CODEX_SPARK_FIRST_ATTEMPT_REQUIRED"
    end

    if lane == "M2" && PRIME_MODELS.include?(input.fetch("resolved_model")) &&
       blank?(input.fetch("model_escalation_receipt"))
      return "MODEL_ESCALATION_RECEIPT_REQUIRED"
    end
  end

  return "FALLBACK_MODEL_REQUIRED" if input.fetch("fallback_used") == true && blank?(input.fetch("fallback_model"))
  return "FALLBACK_REASON_REQUIRED" if input.fetch("fallback_used") == true &&
                                        blank?(input.fetch("fallback_reason"))

  if input.fetch("fallback_used") == true
    fallback = input.fetch("fallback_model")
    return "M2_FALLBACK_MODEL_NOT_ALLOWED" unless M2_ALLOWED_FALLBACKS.include?(fallback) ||
                                                   !route_surface_is_code || lane != "M2"

    if fallback == "gpt-5.5" &&
       lane == "M2" &&
       blank?(input.fetch("model_escalation_receipt"))
      return "MODEL_ESCALATION_RECEIPT_REQUIRED"
    end

    return "M2_FALLBACK_FIRST_ORDER_VIOLATED" if lane == "M2" &&
                                                 input.fetch("first_attempt_model") == SPARK &&
                                                 fallback == "gpt-5.4" &&
                                                 !input.fetch("fallback_reason").match?(/5\.4-mini|gpt-5\.4-mini|low[-_]cost/i)
  end

  "AGENTHUB_MODEL_ROUTE_DECISION_PASS"
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
