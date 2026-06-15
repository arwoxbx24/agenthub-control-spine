#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0, "fixtures/task-service-summary-hygiene/fixtures.json")
doc = JSON.parse(File.read(path))

PLACEHOLDERS = [
  "task-service backlog request",
  "backlog request",
  "new task",
  "untitled"
].freeze

SKIP_WORDS = %w[stale duplicate superseded closed].freeze

def blank?(value)
  value.nil? || value.to_s.strip.empty?
end

def placeholder?(summary)
  text = summary.to_s.strip.downcase
  blank?(text) || PLACEHOLDERS.include?(text)
end

def evidence_complete?(input)
  input["implementation_evidence"] == true &&
    input["validation_evidence"] == true &&
    input["receipt"] == true
end

def duplicate_like?(summary)
  text = summary.to_s.downcase
  text.include?("duplicate") || text.include?("дуб")
end

def linked?(input)
  !blank?(input["parent_task_id"]) || !blank?(input["duplicate_signature"])
end

def evaluate(input)
  return "SUMMARY_PLACEHOLDER_REJECTED" if placeholder?(input["summary"])
  return "TASK_ID_MISSING" unless input["task_id"].to_s.match?(/\A[A-Z][A-Z0-9]+-\d+\z/)
  return "DONE_EVIDENCE_MISSING" if input["stage"] == "Done" && !evidence_complete?(input)
  return "BLOCKER_STATE_MISSING" if blank?(input["blocker"])
  return "DUPLICATE_LINKAGE_MISSING" if duplicate_like?(input["summary"]) && !linked?(input)

  "TASK_SUMMARY_ALLOWED"
end

failures = doc.fetch("cases").filter_map do |item|
  actual = evaluate(item.fetch("input"))
  expected = item.fetch("expected")
  next if actual == expected

  { "id" => item.fetch("id"), "expected" => expected, "actual" => actual }
end

if failures.empty?
  puts JSON.generate({ "status" => "PASS", "cases" => doc.fetch("cases").length, "validator" => File.basename(__FILE__) })
else
  warn JSON.pretty_generate({ "status" => "FAIL", "failures" => failures })
  exit 1
end
