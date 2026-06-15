#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

DISTRESS_PATTERN = /site broken|client screaming|production broken|you destroyed the site|panic|karau|караул|сайт.*слом|прод.*слом|рабочий сайт.*слом|восстанови сайт/i
PROD_BRANCHES = %w[main master].freeze
ACTIVE_TAIL_STATES = %w[open active backlog develop review test].freeze
PROD_PHRASE = "разрешаю отгрузку на прод"

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def pass?(input, key)
  input[key] == true || input[key] == "PASS"
end

def task_bound?(input)
  !blank?(input["task_id"]) && !blank?(input["run_id"]) && !blank?(input["scope_signature"])
end

def classify_environment(input)
  return "PROD_RISK_UNKNOWN" if input["product_repository"] == true && PROD_BRANCHES.include?(input["branch"].to_s)
  return "WORKFLOW_SIDE_EFFECT_UNKNOWN" if input["workflow_action"] == true && input["workflow_impact_audit"] != "PASS"
  return "ARCHIVED_REMOTE" if input["remote_state"] == "archived"
  return "READ_ONLY_REMOTE" if input["remote_state"] == "read_only"
  return "TEST_SERVER" if input["test_only_route_proof"] == "PASS"
  return "PRODUCTION" if input["production"] == true && input["environment_classification"] == "PRODUCTION"
  return "LOCAL_ONLY" if input["local_only"] == true

  "PROD_RISK_UNKNOWN"
end

def done_ready?(input)
  pass?(input, "implementation_evidence") &&
    pass?(input, "validation_evidence") &&
    pass?(input, "receipt") &&
    pass?(input, "task_readback") &&
    pass?(input, "register_coverage") &&
    input["blocker"] == "NONE" &&
    input["only_github_workflow_success"] != true &&
    input["only_pr_merged"] != true &&
    input["only_local_check_for_browser_claim"] != true &&
    Array(input["open_tails"]).none? { |tail| ACTIVE_TAIL_STATES.include?(tail.to_s.downcase) }
end

def route(input)
  return "TASK_BINDING_MISSING" unless task_bound?(input)

  env = classify_environment(input)
  distress = input["owner_message"].to_s.match?(DISTRESS_PATTERN)

  if input["gate"] == "environment"
    return "ENVIRONMENT_CLASSIFICATION_MISSING" if input["environment_classification"].to_s.empty?
    return "TEST_ONLY_ROUTE_PROOF_MISSING" if env == "PROD_RISK_UNKNOWN" && input["operation"] == "test_task"
    return "TEST_ONLY_ROUTE_PROOF_MISSING" if env == "ARCHIVED_REMOTE" && input["workaround_remote"] == true
    return "ENVIRONMENT_CLASSIFICATION_PASS"
  end

  if input["gate"] == "workflow"
    return "WORKFLOW_IMPACT_AUDIT_MISSING" if input["workflow_action"] == true && input["workflow_impact_audit"] != "PASS"
    return "PROD_RELEASE_AUTHORIZATION_MISSING" if input["workflow_touches_production"] == true && input["owner_phrase"] != PROD_PHRASE
    return "WORKFLOW_IMPACT_AUDIT_PASS"
  end

  if input["gate"] == "prod_release"
    return "PROD_RELEASE_AUTHORIZATION_MISSING" unless input["owner_phrase"] == PROD_PHRASE
    return "TEST_ONLY_ROUTE_PROOF_MISSING" unless input["test_only_route_proof"] == "PASS"
    return "PROD_RELEASE_AUTHORIZED"
  end

  if input["gate"] == "owner_incident"
    return "OWNER_INCIDENT_SIGNAL_NOT_ROUTED" if distress && input["incident_profile"] != "INCIDENT"
    return "OWNER_INCIDENT_SIGNAL_NOT_ROUTED" if distress && input["agent_reply"].to_s.match?(/I stop|останов|извин|sorry|apolog/i) && input["read_only_triage_started"] != true
    return "SAFE_RECOVERY_LANE_STARTED" if distress && input["read_only_triage_started"] == true && input["state_capture"] == "PASS"
    return "OWNER_INCIDENT_SIGNAL_NOT_ROUTED" if distress
    return "NO_INCIDENT_SIGNAL"
  end

  if input["gate"] == "rollback"
    return "LAST_KNOWN_GOOD_REVISION_MISSING" if blank?(input["last_known_good"])
    return "SAFE_ROLLBACK_LANE_MISSING" unless pass?(input, "pre_registered_lane") && pass?(input, "reversible") && pass?(input, "checkpoint")
    return "PRODUCTION_FIX_OUTSIDE_ROLLBACK_LANE_BLOCKED" if input["feature_fix_on_production"] == true
    return "OWNER_ONLY_IRREVERSIBLE_GATE" if input["forbidden_surface"] == true
    return "SAFE_ROLLBACK_AUTHORIZED"
  end

  if input["gate"] == "pr171"
    return "PR171_GITLEAKS_MERGE_GATE_BLOCKED" unless pass?(input, "gitleaks")
    return "PLATFORM_BRANCH_PROTECTION_GATE" if input["branch_protection_blocked"] == true
    return "VALIDATION_EVIDENCE_MISSING" unless pass?(input, "task_readback") && pass?(input, "register_coverage") && Array(input["open_tails"]).empty?
    return "PR171_TERMINAL_CLOSURE_ALLOWED"
  end

  if input["terminal_request"] == "Done"
    return "VALIDATION_EVIDENCE_MISSING" unless done_ready?(input)
    return "DONE_WITH_EVIDENCE"
  end

  "FOUR_PROMPTS_SYSTEM_HARDLOCK_PASS"
end

failures = cases.filter_map do |item|
  actual = route(item.fetch("input"))
  expected = item.fetch("expected")
  next if actual == expected

  { "id" => item.fetch("id"), "expected" => expected, "actual" => actual }
end

if failures.empty?
  puts JSON.pretty_generate({
    "status" => "PASS",
    "cases" => cases.length,
    "validator" => File.basename(__FILE__)
  })
else
  warn JSON.pretty_generate({ "status" => "FAIL", "failures" => failures })
  exit 1
end

