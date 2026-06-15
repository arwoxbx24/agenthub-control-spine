#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

CANONICAL_REPO = "arwoxbx24/agenthub-control-spine"
PRODUCT_REPO_PATTERN = /stroyremont|product|prod-site|client-site/i

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def pass?(input, key)
  input[key] == true || input[key] == "PASS"
end

def task_bound?(input)
  input["task_id"].to_s.match?(/\A[A-Z][A-Z0-9]+-\d+\z/) && !blank?(input["run_id"])
end

def allowed_gh_scope?(input)
  task_bound?(input) &&
    input["repository"] == CANONICAL_REPO &&
    Array(input["allowed_paths"]).any? &&
    input["gh_fallback"] == true &&
    input["workflow_dispatch"] != true &&
    input["secret_output"] != true
end

def evaluate(input)
  return "AGENTHUB_ROUTE_MISSING" unless task_bound?(input)
  return "GH_FALLBACK_SCOPE_UNSAFE" if input["repository"].to_s.match?(PRODUCT_REPO_PATTERN)
  return "GH_FALLBACK_SCOPE_UNSAFE" if input["product_runtime_mutation"] == true
  return "GH_FALLBACK_SCOPE_UNSAFE" if input["unlimited_permission_grant"] == true
  return "AGENTHUB_ROUTE_MISSING" if input["direct_shell_bypass"] == true
  return "BRANCH_PROTECTION_PLATFORM_GATE" if input["branch_protection_bypass"] == true
  return "CONTROL_SPINE_WRITE_ROUTE_MISSING" if input["owner_shell_handoff"] == true
  return "CONTROL_SPINE_WRITE_ROUTE_MISSING" if input["blocked_command_retries"].to_i >= 2
  return "CONTROL_SPINE_WRITE_ROUTE_MISSING" if input["command_obfuscation"] == true
  return "CONTROL_SPINE_WRITE_ROUTE_MISSING" if input["local_prompt_index_done"] == true

  if input["connector_failed"] == true
    return "GITHUB_CONNECTOR_AND_GH_FALLBACK_UNAVAILABLE" unless input["gh_fallback_checked"] == true
    return "GH_FALLBACK_SCOPE_UNSAFE" unless allowed_gh_scope?(input)
    return "GH_FALLBACK_ALLOWED"
  end

  if input["same_run_packfix"] == true
    return "SAME_RUN_PACKFIX_PASS" if input["routine_blocker"] == true && input["owner_shell_handoff"] != true
  end

  if input["terminal_request"] == "Done"
    return "YOUTRACK_READBACK_UNAVAILABLE" unless pass?(input, "task_readback")
    return "BRANCH_PROTECTION_PLATFORM_GATE" unless pass?(input, "main_readback")
    return "REGISTER_UPDATE_UNAVAILABLE" unless pass?(input, "register_coverage")
    return "VALIDATOR_FIXTURE_GATE" unless pass?(input, "validation")
    return "DONE_WITH_EVIDENCE"
  end

  "OMEGA_FALLBACK_PERMISSION_LANE_PASS"
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

