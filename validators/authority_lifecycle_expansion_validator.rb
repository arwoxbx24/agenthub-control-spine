#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0, "evals/authority-lifecycle-expansion/fixtures.json")
doc = JSON.parse(File.read(path))
failures = []

def expect(id, actual, expected)
  return nil if actual == expected

  { "id" => id, "expected" => expected, "actual" => actual }
end

doc.fetch("cases").each do |item|
  input = item.fetch("input")
  case item.fetch("gate")
  when "authority_envelope"
    actual = if input["authority_envelope"].nil?
               "MISSING_AUTHORITY_ENVELOPE"
             elsif input.dig("authority_envelope", "decision") == "BLOCK"
               "GENERIC_BLOCK_FORBIDDEN"
             elsif input.dig("authority_envelope", "lane").to_i.between?(0, 7)
               "AUTHORITY_ENVELOPE_PASS"
             else
               "AUTHORITY_LANE_INVALID"
             end
  when "packfix"
    count = input.fetch("same_blocker_count", 0).to_i
    owner_only = input.fetch("owner_only", false)
    actual = if owner_only
               "OWNER_ONLY_GATE"
             elsif count >= 3
               "THIRD_IDENTICAL_RETRY_FORBIDDEN"
             elsif count >= 2
               "ROUTE_REPAIR_REQUIRED"
             else
               "PACKFIX_REQUIRED"
             end
  when "done"
    actual = if input.fetch("prompt_dump", false)
               "PROMPT_DUMP_FORBIDDEN"
             elsif input.fetch("http_200_only", false)
               "HTTP_200_FAKE_DONE"
             elsif input.fetch("env_only_model_claim", false)
               "ENV_ONLY_MODEL_PROOF_REJECTED"
             elsif input.fetch("validator_executed", false) != true
               "VALIDATOR_NOT_RUN"
             elsif input.fetch("task_stage", "") == "Done" && input.fetch("active_blockers", []).any?
               "DONE_WITH_ACTIVE_BLOCKERS_FORBIDDEN"
             else
               "DONE_GATE_PASS"
             end
  else
    actual = "UNKNOWN_GATE"
  end

  failures << expect(item.fetch("id"), actual, item.fetch("expected"))
end

failures.compact!

if failures.empty?
  puts JSON.pretty_generate({ "status" => "PASS", "cases" => doc.fetch("cases").length, "validator" => File.basename(__FILE__) })
else
  warn JSON.pretty_generate({ "status" => "FAIL", "failures" => failures })
  exit 1
end
