#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

def done_decision(input)
  return "NOT_DONE_CONTROL_SPINE_RECEIPT_MISSING" unless input.fetch("receipt_path", false)
  return "NOT_DONE_AUDIT_MISSING" unless input.fetch("audit_path", false)
  return "NOT_DONE_REGISTER_MISSING" unless input.fetch("index_registered", false) && input.fetch("artifact_registered", false)
  return "NOT_DONE_PR_QUEUE_MISSING" unless input.fetch("pr_queue_registered", false)
  return "NOT_DONE_TASK_READBACK_MISSING" unless input.fetch("task_readback", false)
  return "NOT_DONE_SECRET_SCAN_MISSING" unless input.fetch("secret_scan", false)

  "DONE_WITH_EVIDENCE"
end

failures = cases.filter_map do |item|
  actual = done_decision(item.fetch("input"))
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
