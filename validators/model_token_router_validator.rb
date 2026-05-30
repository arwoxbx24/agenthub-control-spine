#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

def route(input)
  return "ARCHITECTURE_REPAIR_REQUIRED" if input.fetch("same_gate_failures", 0).to_i >= 2
  if input.fetch("wrong_task_recovery", false)
    wrong_change = input.fetch("wrong_task_change_type", "").to_s
    if wrong_change == "lease_requeue" && input.fetch("counts_as_code_authoring_model_proof", false)
      return "WRONG_TASK_EXECUTION_RECOVERY_REQUIRED"
    end
  end

  if input.fetch("primary_model_burn_circuit_breaker", false)
    primary_models = %w[gpt-5.5 main base primary]
    codex_models = %w[gpt-5.3-codex-spark gpt-5.3-codex gpt-5.1-codex-mini gpt-5.4-mini]
    surface = input.fetch("task_surface", "").to_s
    code_surface = input.fetch("code_config_surface", false) ||
                   surface.match?(/\b(code|config|yaml|shell|programming|test|frontend|backend|iac)\b/i)
    actor_role = input.fetch("actor_role", input.fetch("task_class", "")).to_s
    actor_model = input.fetch("actor_model", input.fetch("worker_model", "")).to_s

    if code_surface
      return "PRIMARY_MODEL_BURN_CIRCUIT_BREAKER_UNAVAILABLE" unless input.fetch("circuit_breaker_active", false)
      return "PRIMARY_MODEL_CODE_AUTHORSHIP_DETECTED" if primary_models.include?(actor_model)
      return "T0_DIRECT_CODE_AUTHORSHIP_DETECTED" if actor_role == "T0_CONTROL" && input.fetch("requests_code_or_command", false)
      if input.fetch("codex_cli_model_selector_available", input.fetch("codex_cloud_available", false)) &&
         actor_model != "gpt-5.3-codex-spark"
        return "CODEX_SPARK_CODE_AUTHORING_REQUIRED"
      end

      if input.fetch("fallback_used", false)
        return "FALLBACK_WITHOUT_SPARK_UNAVAILABILITY_PROOF" unless input.fetch("same_run_spark_unavailable_proof", false)
        return "CODEX_SPARK_ROUTE_NOT_EXECUTED" unless codex_models.include?(actor_model)
      end

      return "CODEX_SPARK_ROUTE_REQUIRED" unless codex_models.include?(actor_model)
    end
  end

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

    if input.fetch("code_authoring_model_enforcement", false)
      requested_model = input.fetch("requested_model", input.fetch("cli_requested_model", "")).to_s
      actual_model = input.fetch("actual_model", input.fetch("resolved_model", model)).to_s
      artifact_path = input.fetch("code_artifact_path", input.fetch("proof_artifact_path", "")).to_s

      return "PRIMARY_MODEL_CODE_AUTHORSHIP_DETECTED" if %w[gpt-5.5 main base primary].include?(model) ||
                                                         %w[gpt-5.5 main base primary].include?(actual_model)
      return "CODEX_SPARK_MODEL_SELECTOR_NOT_SET" if requested_model.empty?
      return "CODEX_SPARK_CODE_AUTHORING_REQUIRED" unless requested_model == "gpt-5.3-codex-spark"
      return "FALLBACK_WITHOUT_SPARK_UNAVAILABILITY_PROOF" if input.fetch("fallback_used", false) &&
                                                              !input.fetch("same_run_spark_unavailable_proof", false)
      return "CODEX_SPARK_RESOLVED_MODEL_MISMATCH" unless actual_model == "gpt-5.3-codex-spark"
      return "MODEL_ROUTE_EVIDENCE_MISSING" if artifact_path.empty?

      return "CODEX_SPARK_CODE_AUTHORING_PASS"
    end

    if input.fetch("spark_execution_proof_closure", false)
      valid_proof_sources = %w[platform_resolved_model_receipt owner_visible_usage_delta codex_cli_json_usage_receipt]
      rejected_proof_sources = %w[
        command_request worker_self_report policy_only validator_only merged_pr sandbox_only
      ]
      actual_model = input.fetch("actual_model", "").to_s
      proof_source = input.fetch("model_proof_source", "").to_s

      if proof_source == "codex_cli_json_usage_receipt"
        cli_model = input.fetch("cli_requested_model", "").to_s
        input_tokens = input.fetch("usage_input_tokens", 0).to_i
        output_tokens = input.fetch("usage_output_tokens", 0).to_i
        fallback_used = input.fetch("fallback_used", false)

        return "CODEX_SPARK_USAGE_TELEMETRY_UNAVAILABLE" if input.fetch("usage_metric_status", "") == "contradicted"
        return "CODEX_SPARK_ROUTE_NOT_EXECUTED" unless actual_model.empty? || actual_model == "gpt-5.3-codex-spark"
        return "CODEX_SPARK_EXECUTION_NOT_PROVEN" unless cli_model == "gpt-5.3-codex-spark"
        return "CODEX_SPARK_EXECUTION_NOT_PROVEN" unless input_tokens.positive? && output_tokens.positive?
        return "CODEX_SPARK_ROUTE_NOT_EXECUTED" if fallback_used

        return "CODEX_SPARK_EXECUTION_PROOF_PASS"
      end

      return "CODEX_SPARK_EXECUTION_NOT_PROVEN" if actual_model.empty?
      return "CODEX_SPARK_ROUTE_NOT_EXECUTED" unless actual_model == "gpt-5.3-codex-spark"
      return "CODEX_SPARK_USAGE_TELEMETRY_UNAVAILABLE" if input.fetch("usage_metric_status", "") == "contradicted"
      return "CODEX_SPARK_USAGE_TELEMETRY_UNAVAILABLE" if rejected_proof_sources.include?(proof_source)
      return "CODEX_SPARK_USAGE_TELEMETRY_UNAVAILABLE" unless valid_proof_sources.include?(proof_source)

      return "CODEX_SPARK_EXECUTION_PROOF_PASS"
    end

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
