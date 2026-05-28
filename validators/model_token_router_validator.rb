#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

def route(input)
  return "SAME_GATE_LOOP_BLOCKED" if input.fetch("same_gate_failures", 0).to_i >= 2

  case input.fetch("task_class")
  when "T0_CONTROL"
    return "DENY_CODE_OR_COMMAND_FOR_T0" if input.fetch("requests_code_or_command", false)
    "CONTROL_MODEL_ALLOWED"
  when "T1_ARCHITECT"
    "REASONING_MODEL_ALLOWED_WITH_BOUNDED_SOURCE_PACKET"
  when "T2_CODEX_IMPLEMENTER"
    input.fetch("model_class") == "CODEX_CAPABLE" ? "CODEX_WORKER_REQUIRED_PASS" : "CODEX_CAPABLE_MODEL_REQUIRED"
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
