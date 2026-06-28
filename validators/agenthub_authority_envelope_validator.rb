#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0, "evals/authority-broker/fixtures.json")
doc = JSON.parse(File.read(path))
cases = doc.fetch("authority_cases")

failures = cases.filter_map do |item|
  input = item.fetch("input")
  env = input["authority_envelope"]
  actual = if env.nil?
             "AUTHORITY_ENVELOPE_MISSING"
           elsif env["decision"] == "BLOCK"
             "GENERIC_BLOCK_FORBIDDEN"
           elsif !(0..7).include?(env.fetch("lane", -1).to_i)
             "LANE_INVALID"
           elsif env.fetch("task_id", "").empty? || env.fetch("run_id", "").empty?
             "TASK_RUN_MISSING"
           else
             "AUTHORITY_ENVELOPE_PASS"
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
