#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")
all_methods = (1..25).to_a

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def missing_selection?(input)
  %w[
    TASK_CLASS ROLE ACTIVE_METHODS FORBIDDEN_METHODS ACTIVE_SKILLS
    FORBIDDEN_SKILLS SCOPE_SIGNATURE NEGATIVE_MATCHES RUN_ID EVIDENCE_TARGETS
  ].any? { |field| blank?(input[field]) && !%w[FORBIDDEN_METHODS FORBIDDEN_SKILLS].include?(field) }
end

decision = lambda do |input|
  return "PROJECT_SOURCE_MIRROR_INVALID" if input.fetch("kind", "router") == "source_mirror" &&
                                           (input.fetch("stable_project_sources", []).length != 5 ||
                                            !input.fetch("not_sixth_project_source", false) ||
                                            input.fetch("raw_html_stored", true) ||
                                            blank?(input.dig("methodology_source", "sha256")) ||
                                            input.dig("methodology_source", "read_route") != "agent_link_read")

  return "PROJECT_SOURCE_MIRROR_VALID" if input.fetch("kind", "router") == "source_mirror"
  return "BLOCKED_T0_DIRECT_AUTHORSHIP" if input.fetch("ROLE", "") == "T0_CONTROL" &&
                                           %w[code_write shell_command runtime_mutate docker db proxy].include?(input.fetch("operation", ""))
  return "METHOD_ROUTER_SELECTION_MISSING" if missing_selection?(input)
  return "TOKEN_BLOAT_METHOD_OVERLOAD_BLOCKED" if input.fetch("ACTIVE_METHODS", []).map(&:to_i).sort == all_methods &&
                                                  !input.fetch("all_methods_justified", false)
  return "INCIDENT_METHODS_MISSING" if input.fetch("TASK_CLASS", "") == "INCIDENT" &&
                                      ([19, 20, 21] - input.fetch("ACTIVE_METHODS", []).map(&:to_i)).any?
  return "ARCHITECTURE_METHODS_MISSING" if input.fetch("TASK_CLASS", "") == "FULL" &&
                                           (!input.fetch("ACTIVE_METHODS", []).include?(5) ||
                                            !input.fetch("three_options_recorded", false))
  return "CODEX_MODEL_ROUTE_MISSING" if input.fetch("code_like", false) && !input.fetch("codex_route_attempted", false)
  return "FAKE_DONE_BLOCKED" if input.fetch("github_only_done", false) || input.fetch("sandbox_only_done", false)
  return "REPORT_ONLY_NOT_DONE" if input.fetch("report_written", false) &&
                                   (!input.fetch("register_updated", false) || !input.fetch("youtrack_readback", false))
  return "REPORT_AS_INSTRUCTION_BLOCKED" if input.fetch("artifact_lifecycle", "") == "audit_only" &&
                                           input.fetch("used_as_instruction", false)
  return "THIRD_RETRY_BLOCKED_REQUIRE_ARCHITECTURE_REPAIR" if input.fetch("same_gate_failures", 0).to_i >= 2
  return "OWNER_ONLY_IRREVERSIBLE_GATE" if input.fetch("missing_account_credential", false)

  "ALLOW_METHOD_ROUTER_SELECTION"
end

failures = cases.filter_map do |item|
  actual = decision.call(item.fetch("input"))
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
