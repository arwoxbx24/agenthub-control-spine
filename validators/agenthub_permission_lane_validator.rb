#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

REQUIRED = %w[run_id task_id lane role allowed_surfaces forbidden_surfaces evidence expiry receipt_path].freeze
ROLE_LANES = {
  0 => %w[T0 T1 Registrar Verifier],
  1 => %w[T0 T1 T2_YouTrack_Worker Verifier],
  2 => %w[Registrar T2_Git_Worker],
  3 => %w[T2_Runtime_Diagnostic_Worker Verifier],
  4 => %w[T2_Runtime_Repair_Worker Verifier],
  5 => %w[T2_Deploy_Worker Verifier],
  6 => %w[T2_Destructive_Worker Verifier Owner]
}.freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def validate_case(input)
  return "LANE_PERMISSION_MANIFEST_MISSING" if REQUIRED.any? { |field| blank?(input[field]) }
  lane = input.fetch("lane").to_i
  return "LANE_PERMISSION_MANIFEST_MISSING" unless ROLE_LANES.key?(lane)
  return "ROLE_NOT_AUTHORIZED_FOR_LANE" unless ROLE_LANES.fetch(lane).include?(input.fetch("role"))
  return "SECRET_RISK_QUARANTINE" if input.fetch("secret_redaction", "PASS") != "PASS"
  return "OWNER_ONLY_DESTRUCTIVE_CONFIRMATION_REQUIRED" if lane == 6 && input.fetch("lane6_proof", "missing") != "PASS"
  return "NO_APPROVED_RUNTIME_WORKER_ROUTE" if [3, 4, 5].include?(lane) && input.fetch("worker_route", "missing") != "PASS"

  "PASS"
end

payload = JSON.parse(File.read(ARGV.fetch(0)))
failures = payload.fetch("permission_lane_cases").filter_map do |item|
  actual = validate_case(item.fetch("input"))
  expected = item.fetch("expected")
  next if actual == expected

  { "id" => item.fetch("id"), "expected" => expected, "actual" => actual }
end

if failures.empty?
  puts JSON.pretty_generate({ "status" => "PASS", "validator" => File.basename(__FILE__), "cases" => payload.fetch("permission_lane_cases").length })
else
  warn JSON.pretty_generate({ "status" => "FAIL", "failures" => failures })
  exit 1
end
