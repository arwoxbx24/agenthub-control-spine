#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

PROD_BRANCHES = %w[main master].freeze
PROD_PHRASE = "разрешаю отгрузку на прод"

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def pass?(input, key)
  input[key] == true || input[key] == "PASS"
end

def task_bound?(input)
  input["task_id"].to_s.match?(/\A[A-Z][A-Z0-9]+-\d+\z/) && !blank?(input["run_id"])
end

def evaluate(input)
  return "TASK_BINDING_GATE" unless task_bound?(input)
  return "AGENTHUB_ROUTE_MISSING" if input["direct_shell_bypass"] == true || input["agenthub_route"] == false
  return "NO_PRODUCT_TOUCH_GATE" if input["product_runtime_mutation"] == true
  return "INSTALLED_CONTROL_GATE" if input["local_prompt_index_used_as_implementation"] == true
  return "CONTROL_SPINE_WRITE_ROUTE_MISSING" if input["owner_shell_handoff"] == true
  return "CONTROL_SPINE_WRITE_ROUTE_MISSING" if input["blocked_command_retries"].to_i > 1

  if input["gate"] == "environment"
    return "PROD_RELEASE_AUTHORIZATION_MISSING" if input["product_repo"] == true && PROD_BRANCHES.include?(input["branch"].to_s) && input["owner_phrase"] != PROD_PHRASE
    return "VALIDATOR_FIXTURE_GATE" if input["environment_route_proof"] != "PASS"
  end

  if input["gate"] == "workflow"
    return "VALIDATOR_FIXTURE_GATE" if input["workflow_action"] == true && input["workflow_impact_audit"] != "PASS"
  end

  if input["gate"] == "owner_incident"
    return "CONTROL_SPINE_WRITE_ROUTE_MISSING" if input["owner_handoff_for_routine_step"] == true
    return "VALIDATOR_FIXTURE_GATE" if input["incident_signal"] == true && input["safe_recovery_started"] != true
  end

  if input["gate"] == "pr171"
    return "GITHUB_BRANCH_PROTECTION_PLATFORM_GATE" if input["same_merge_error_count"].to_i >= 2
    return "VALIDATOR_FIXTURE_GATE" if input["gitleaks"] != "PASS"
  end

  if input["terminal_request"] == "Done"
    return "INSTALLED_CONTROL_GATE" if input["chat_report_only"] == true
    return "VALIDATOR_FIXTURE_GATE" unless pass?(input, "validation")
    return "REGISTER_UPDATE_UNAVAILABLE" unless pass?(input, "register_coverage")
    return "YOUTRACK_READBACK_UNAVAILABLE" unless pass?(input, "task_readback")
    return "GITHUB_BRANCH_PROTECTION_PLATFORM_GATE" unless pass?(input, "main_readback")
    return "DONE_WITH_EVIDENCE"
  end

  "FOUR_PROMPT_ARCHITECTURE_HARDLOCK_PASS"
end

failures = cases.filter_map do |item|
  actual = evaluate(item.fetch("input"))
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

