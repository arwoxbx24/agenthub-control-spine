#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

REQUIRED = %w[
  run_id task_id lane actor_role action_class target_surface
  allowed_surfaces forbidden_surfaces evidence_path receipt_path
].freeze

LANE_ROLE_ALLOW = {
  1 => %w[T0_REGISTRAR T1_ARCHITECT T2_REPO_WRITER REGISTRAR],
  2 => %w[T0_REGISTRAR T2_REPO_WRITER REGISTRAR],
  3 => %w[T0_ROUTER T1_ARCHITECT REGISTRAR],
  4 => %w[T2_READONLY_DIAGNOSTIC_WORKER VERIFIER],
  5 => %w[T2_REVERSIBLE_REPAIR_WORKER VERIFIER],
  6 => %w[T2_DESTRUCTIVE_CLEANUP_WORKER VERIFIER]
}.freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def decision(input)
  return "POLICY_DEFECT_CAPABILITY_FIELDS_MISSING" if REQUIRED.any? { |field| blank?(input[field]) }
  return "SAME_GATE_LOOP_LIMIT_REACHED" if input.fetch("same_gate_failures", 0).to_i >= 2

  lane = input.fetch("lane").to_i
  role = input.fetch("actor_role")
  action = input.fetch("action_class")
  surface = input.fetch("target_surface")

  return "BLOCKED_T0_DIRECT_RUNTIME_ACTION" if role.start_with?("T0") && lane >= 4
  return "SECRET_EXPOSURE_RISK" if input.fetch("secret_redaction", "PASS") != "PASS"

  unless LANE_ROLE_ALLOW.fetch(lane, []).include?(role)
    return case lane
           when 1 then "ROUTE_TO_SCOPED_REPO_WRITER"
           when 4 then "ROUTE_TO_READONLY_DIAGNOSTIC_WORKER"
           when 5 then "ROUTE_TO_REVERSIBLE_REPAIR_WORKER"
           else "NO_APPROVED_WORKER_ROUTE_AFTER_REPAIR"
           end
  end

  return "AUTO_WRITE_MODEL_FALLBACK_RECEIPT" if input.fetch("blocker_type", "") == "MODEL_FALLBACK_RECEIPT_MISSING"

  case lane
  when 1
    return "ALLOW_LANE1_CONTROL_SPINE_WRITE" if %w[WRITE_ARTIFACT UPDATE_POLICY UPDATE_SCHEMA UPDATE_VALIDATOR UPDATE_REGISTER].include?(action)
  when 2
    return "ALLOW_LANE2_REPOSITORY_HYGIENE" if action == "DELETE_BRANCH" && input["sha_pinned"] == true && input["open_pr_check"] == true && input["protected_branch_check"] == true
  when 3
    return "ALLOW_LANE3_TASK_RUN_SELF_HEALING" if %w[CREATE_TASK LINK_TASK BIND_RUN WRITE_ROUTE_RECEIPT WRITE_FALLBACK_RECEIPT].include?(action)
  when 4
    return "ALLOW_LANE4_READONLY_DIAGNOSTIC" if input["read_only"] == true && %w[SERVICE_STATUS CONTAINER_LIST REDACTED_LOG_SUMMARY HTTP_HEALTH].include?(action)
  when 5
    return "ALLOW_LANE5_REVERSIBLE_RUNTIME_REPAIR" if input["rollback_present"] == true && %w[SERVICE_RESTART NARROW_CONFIG_PATCH RESTORE_CHECKPOINT].include?(action)
  when 6
    return "OWNER_ONLY_DESTRUCTIVE_CONFIRMATION_REQUIRED" if input["owner_confirmation"] != true && input["replacement_proof"] != true && input["backup_proof"] != true && input["stale_target_proof"] != true
    return "LANE6_PROOF_MISSING" if blank?(input["destruction_proof_path"])
    return "ALLOW_LANE6_DESTRUCTIVE_CLEANUP"
  end

  "NO_APPROVED_WORKER_ROUTE_AFTER_REPAIR"
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
