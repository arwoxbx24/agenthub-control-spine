#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0, "evals/runtime-tool-installation/fixtures.json")
doc = JSON.parse(File.read(path))
cases = doc.fetch("route_cases")

failures = cases.filter_map do |item|
  route = item.fetch("input").fetch("route_manifest", nil)
  actual = if route.nil?
             "ROUTE_MANIFEST_MISSING"
           elsif route.fetch("redaction_gate", "") != "PASS"
             "REDACTION_GATE_FAIL"
           elsif route.dig("canary", "status") != "PASS"
             "ROUTE_CANARY_MISSING"
           elsif route.dig("validation", "status") != "PASS"
             "ROUTE_VALIDATION_MISSING"
           else
             "RUNTIME_TOOL_ROUTE_PASS"
           end
  next if actual == item.fetch("expected")

  { "id" => item.fetch("id"), "expected" => item.fetch("expected"), "actual" => actual }
end

if failures.empty?
  puts JSON.pretty_generate("status" => "PASS", "cases" => cases.length)
else
  warn JSON.pretty_generate("status" => "FAIL", "failures" => failures)
  exit 1
end
