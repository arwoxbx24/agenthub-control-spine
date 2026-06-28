#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0, "evals/packfix-loop/fixtures.json")
doc = JSON.parse(File.read(path))
cases = doc.fetch("packfix_cases")

failures = cases.filter_map do |item|
  input = item.fetch("input")
  actual = if input.fetch("owner_only", false)
             "OWNER_ONLY_TERMINAL"
           elsif input.fetch("same_blocker_count", 0).to_i >= 3
             "THIRD_RETRY_FORBIDDEN"
           elsif input.fetch("same_blocker_count", 0).to_i >= 2
             "ROUTE_REPAIR_REQUIRED"
           else
             "PACKFIX_REQUIRED"
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
