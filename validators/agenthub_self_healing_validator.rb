#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

REQUIRED_FIELDS = %w[
  run_id task_id scope_signature actor_role operation target_surface
  allowed_surfaces forbidden_surfaces model_route evidence_path validation_plan
].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def decision(input)
  return "SELF_HEALING_ESCALATION" if input.fetch("same_blocker_count", 0).to_i >= 2
  return "POLICY_DEFECT_CAPABILITY_FIELDS_MISSING" if REQUIRED_FIELDS.any? { |field| blank?(input[field]) }
  return "POLICY_DEFECT_CAPABILITY_FIELDS_MISSING" if blank?(input["allowed_surfaces"]) || blank?(input["forbidden_surfaces"])

  role = input.fetch("actor_role")
  operation = input.fetch("operation")
  surface = input.fetch("target_surface")
  model_route = input.fetch("model_route", {})

  if role == "T0_CONTROL" && %w[runtime_mutate shell_command external_api_write].include?(operation)
    return "BLOCKED_T0_DIRECT_RUNTIME_ACTION"
  end

  if role == "T0_CONTROL" && %w[write_artifact patch_register run_code_model].include?(operation)
    return "BLOCKED_T0_DIRECT_AUTHORSHIP"
  end

  if %w[run_code_model write_artifact patch_register].include?(operation) && input.fetch("report_written", true) && !input.fetch("register_updated", true)
    return "NOT_DONE_REGISTER_COVERAGE_MISSING"
  end

  return "NOT_DONE_TASK_READBACK_MISSING" if input.fetch("pr_merged", false) && !input.fetch("task_readback", true)
  return "NOT_DONE_USER_OUTCOME_MISSING" if input.fetch("localhost_only", false)
  return "STALE_REPORT_REPLAY_BLOCKED" if input.fetch("artifact_lifecycle", "") == "audit_only" && input.fetch("used_as_instruction", false)
  return "WRONG_TASK_CLASS_BLOCKER" if input.fetch("task_class", "") == "telegram_mtproxy" && surface == "NPM_write"
  return "BACKEND_ONLY_OUTPUT_ENFORCED" if input.fetch("owner_requested_no_intermediate", false) && input.fetch("owner_output_mode", "") == "final_only"

  if %w[run_code_model write_artifact patch_register].include?(operation)
    required_model = model_route.fetch("required_model_class", "")
    selected_model = model_route.fetch("selected_model", "")
    code_like = input.fetch("code_like", false)

    if code_like && required_model == "CODEX_CAPABLE" && model_route.fetch("codex_available", false)
      return "MODEL_ROUTE_DEFECT" unless %w[gpt-5.3-codex-spark gpt-5.3-codex].include?(selected_model)
    end

    if code_like && !model_route.fetch("codex_available", true)
      return "MODEL_FALLBACK_DEFECT" unless model_route.fetch("same_run_fallback", false) && !blank?(model_route["fallback_receipt"])
    end
  end

  case input.fetch("defect", "none")
  when "missing_registrar_route"
    "REGISTRAR_ROUTE_REPAIR"
  when "missing_live_worker_route"
    input.fetch("owner_only", false) ? "OWNER_ONLY_GATE" : "LIVE_ROUTE_REPAIR"
  when "duplicate_task"
    "TASK_DEBT_DEDUPLICATE"
  else
    "ALLOW_AUTHORIZED_ACTION"
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
