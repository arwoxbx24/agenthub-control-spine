#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

def route(input)
  return "ARCHITECTURE_REPAIR_REQUIRED" if input.fetch("same_gate_failures", 0).to_i >= 2
  return "MODEL_ROUTE_EVIDENCE_MISSING" if input.fetch("worker_model", "").empty? || input.fetch("model_route_reason", "").empty?

  case input.fetch("task_class")
  when "T0_CONTROL"
    return "DENY_CODE_OR_COMMAND_FOR_T0" if input.fetch("requests_code_or_command", false)
    "CONTROL_MODEL_ALLOWED"
  when "T1_ARCHITECT"
    "REASONING_MODEL_ALLOWED_WITH_BOUNDED_SOURCE_PACKET"
  when "T2_CODEX_IMPLEMENTER"
    codex_primary_model = "gpt-5.3-codex-spark"
    codex_fallback_models = %w[gpt-5.3-codex gpt-5.4-mini gpt-5.4]
    model = input.fetch("worker_model", "")
    requested = input.fetch("requested_model", model)
    resolved = input.fetch("resolved_model", model)
    actual_route = input.fetch("actual_route", resolved)

    return "SANDBOX_ROUTE_NOT_SPARK_PROOF" if actual_route == "agenthub-sandbox-worker"

    if input.fetch("codex_available", false)
      return "CODEX_SPARK_ROUTE_REQUIRED" unless [requested, resolved, actual_route, model].all? { |value| value == codex_primary_model }
      return "FALLBACK_REASON_FORBIDDEN_ON_PRIMARY_ROUTE" unless input.fetch("fallback_reason", nil).nil?

      "CODEX_SPARK_ROUTE_PASS"
    elsif input.fetch("same_run_fallback", false) && codex_fallback_models.include?(model)
      return "FALLBACK_REASON_REQUIRED" if input.fetch("fallback_reason", "").empty?
      return "FALLBACK_PROOF_REQUIRED" unless input.fetch("same_run_fallback_proof", "PASS") == "PASS"
      return "RETURN_TO_SPARK_REQUIRED" unless input.fetch("return_to_spark_when_available", true) == true

      "SAME_RUN_CODEX_FALLBACK_PASS"
    else
      "CODEX_RUNTIME_PROFILE_UNAVAILABLE"
    end
  when "P4_RUNTIME_READ", "P4_RUNTIME_REPAIR"
    input.fetch("has_scope", false) ? "RISK_SCOPED_MODEL_ALLOWED" : "RUNTIME_SCOPE_REQUIRED"
  when "VERIFIER", "REGISTRAR"
    "LOWER_COST_OR_DETERMINISTIC_ROUTE_ALLOWED"
  else
    "MODEL_ROUTE_MISSING"
  end
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
