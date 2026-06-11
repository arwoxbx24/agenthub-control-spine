#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

CODE_ACTIONS = %w[CODE_EDIT CONFIG_EDIT YAML_EDIT TEST_EDIT TEST_EXECUTION IAC_EDIT].freeze
RUNTIME_ACTIONS = %w[RUNTIME_MUTATE DOCKER_MUTATE DB_MUTATE PROXY_MUTATE FIREWALL_MUTATE DNS_MUTATE SERVICE_RESTART].freeze
CONTROL_SPINE_ACTIONS = %w[WRITE_ARTIFACT UPDATE_POLICY UPDATE_SCHEMA UPDATE_VALIDATOR UPDATE_REGISTER WRITE_RECEIPT].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def decision(input)
  required = %w[run_id task_id actor_role actor_model action_class target_surface route_receipt owner_output_mode]
  return "ROLE_STATE_REVALIDATION_MISSING" if required.any? { |field| blank?(input[field]) }
  return "SECRET_REDACTION_GATE_FAILED" unless input.fetch("secret_redaction", "PASS") == "PASS"

  role = input["actor_role"]
  action = input["action_class"]
  surface = input["target_surface"]

  if role == "T0_CONTROL" && CONTROL_SPINE_ACTIONS.include?(action) && surface == "control_spine_repo"
    return input["scoped_repo_writer_available"] == true ? "ROUTE_TO_SCOPED_REPO_WRITER" : "CONTROL_SPINE_AUTHORSHIP_CLASSIFICATION_REPAIR_REQUIRED"
  end

  if role == "T0_CONTROL" && (CODE_ACTIONS.include?(action) || RUNTIME_ACTIONS.include?(action))
    return RUNTIME_ACTIONS.include?(action) ? "BLOCKED_T0_DIRECT_RUNTIME_ACTION" : "BLOCKED_T0_DIRECT_AUTHORSHIP"
  end

  if action == "CLOSE_DONE"
    return "DONE_GATE_EVIDENCE_MISSING" unless input["implementation_evidence"] == "PASS" && input["validation_evidence"] == "PASS" && input["receipt_path"] == "PASS"
    return "ALLOW_DONE_WITH_EVIDENCE"
  end

  case role
  when "T0_CONTROL"
    %w[CLASSIFY ROUTE VERIFY_RECEIPT FINAL_OWNER_SUMMARY].include?(action) ? "ALLOW_T0_CONTROL_ROUTE" : "BLOCKED_T0_DIRECT_AUTHORSHIP"
  when "T1_ARCHITECT"
    %w[DESIGN_GATE APPROVE_WORKER_CONTRACT ADR].include?(action) ? "ALLOW_T1_ARCHITECTURE" : "ROLE_STATE_REVALIDATION_MISSING"
  when "REGISTRAR"
    %w[UPDATE_INDEX UPDATE_ARTIFACT_REGISTER UPDATE_PR_QUEUE WRITE_RECEIPT].include?(action) ? "ALLOW_REGISTRAR_LIFECYCLE" : "FORBIDDEN_SURFACE_BLOCKED"
  else
    "ROLE_STATE_REVALIDATION_MISSING"
  end
end

failures = cases.filter_map do |item|
  actual = decision(item.fetch("input"))
  expected = item.fetch("expected")
  next if actual == expected
  { "id" => item.fetch("id"), "expected" => expected, "actual" => actual }
end

if failures.empty?
  puts JSON.pretty_generate({ "status" => "PASS", "validator" => File.basename(__FILE__), "cases" => cases.length })
else
  warn JSON.pretty_generate({ "status" => "FAIL", "failures" => failures })
  exit 1
end
