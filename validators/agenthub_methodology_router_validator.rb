#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

ALL_METHODS = (1..25).to_a.freeze

PROFILE_REQUIRED = {
  "MICRO" => [],
  "STANDARD" => [1, 3],
  "INCIDENT" => [1, 4, 19, 20, 21, 25],
  "FULL_ARCHITECTURE" => [1, 2, 3, 4, 5, 21, 23, 24],
  "CODE_IMPLEMENTATION" => [1, 3, 9, 10, 18, 23, 24],
  "QA_VALIDATION" => [1, 4, 9, 18, 24],
  "REGISTRAR" => [1, 3, 17, 23, 24]
}.freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def include_all?(actual, required)
  required.all? { |method| actual.include?(method) }
end

def decision(input)
  return "DENY_SECRET_LEAK" if input.fetch("secret_in_output", false)
  return "DENY_STALE_REPORT_REPLAY" if input.fetch("artifact_lifecycle", "") == "audit_only" && input.fetch("used_as_instruction", false)
  return "DENY_BLOCKER_LOOP_SELF_REPAIR_REQUIRED" if input.fetch("same_blocker_count", 0).to_i >= 2
  return "DENY_PARENT_DONE_WITH_OPEN_CHILDREN" if input.fetch("parent_done", false) && input.fetch("open_children", 0).to_i.positive?
  return "DENY_USER_NOISE" if input.fetch("backend_only_mode", false) && input.fetch("intermediate_user_output", false)
  return "DENY_SANDBOX_AS_PRODUCT_DONE" if input.fetch("claims_product_done", false) && input.fetch("sandbox_only", false)

  required_fields = %w[TASK_CLASS ROLE RUN_ID METHODOLOGY_PROFILE ACTIVE_METHODS FORBIDDEN_METHODS WHY_SELECTED EXPECTED_ARTIFACTS ACCEPTANCE_GATES]
  return "DENY_METHOD_CONTEXT_MISSING" if required_fields.any? { |field| blank?(input[field]) && field != "FORBIDDEN_METHODS" }

  profile = input.fetch("METHODOLOGY_PROFILE")
  active = input.fetch("ACTIVE_METHODS", []).map(&:to_i)
  task = input.fetch("TASK_CLASS")

  return "METHODOLOGY_ROUTER_MISSING" if input.fetch("non_trivial", true) && active.empty?
  return "DENY_TOKEN_BLOAT_METHODOLOGY_OVERLOAD" if active.sort == ALL_METHODS && !input.fetch("all_methods_justified", false)
  return "DENY_PROFILE_METHODS_MISSING" unless include_all?(active, PROFILE_REQUIRED.fetch(profile, []))

  if task == "INCIDENT_DEBUG"
    return "DENY_INCIDENT_METHODS_MISSING" unless include_all?(active, [19, 20, 21])
  end

  if task == "ARCHITECTURE"
    return "DENY_ARCH_METHODS_MISSING" unless active.include?(5) && input.fetch("options_recorded", false)
    return "DENY_ARCH_METHODS_MISSING" if input.fetch("system_boundary_applies", false) && !active.include?(6)
    return "DENY_ARCH_METHODS_MISSING" if input.fetch("domain_boundary_applies", false) && !active.include?(7)
  end

  if task == "CODE_CHANGE"
    return "DENY_CODE_METHODS_MISSING" unless include_all?(active, [9, 10, 18])
    return "DENY_MODEL_ROUTER_MISSING" unless input.fetch("codex_route_attempted", false)
  end

  if input.fetch("repo_first_required", false)
    return "DENY_REPO_FIRST_MISSING" if blank?(input["evidence_target_path"])
    return "DENY_GITHUB_ONLY_DONE" if input.fetch("github_only_done", false)
  end

  "ALLOW_METHOD_PROFILE"
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

