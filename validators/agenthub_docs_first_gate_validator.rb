#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0, "evals/docs-first-validator-route-packfix/fixtures.json")
doc = JSON.parse(File.read(path))
cases = doc.fetch("docs_packet_cases", doc.fetch("cases", []))

REQUIRED_PACKET_FIELDS = %w[
  packet_id
  task_id
  run_id
  scope_signature
  packet_owner
  official_sources
  coverage_map
  status
].freeze

REQUIRED_SOURCES = [
  "https://developers.openai.com/codex/cli/reference",
  "https://developers.openai.com/codex/config-basic",
  "https://developers.openai.com/codex/agent-approvals-security",
  "https://modelcontextprotocol.io/docs/tutorials/security/authorization",
  "https://modelcontextprotocol.io/specification/2025-11-25/server/tools",
  "https://www.jetbrains.com/help/youtrack/devportal/youtrack-rest-api.html",
  "https://www.jetbrains.com/help/youtrack/devportal/resource-api-commands.html"
].freeze

REQUIRED_COVERAGE_KEYS = %w[
  openai_cli_reference
  openai_config_basic
  openai_approvals_security
  mcp_authorization
  mcp_tools_spec
  youtrack_rest_api
  youtrack_commands
].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def packet_missing_fields?(packet)
  REQUIRED_PACKET_FIELDS.any? { |field| blank?(packet[field]) } ||
    !packet.fetch("official_sources").is_a?(Array) ||
    !packet.fetch("coverage_map").is_a?(Hash)
end

def all_required_sources_present?(packet)
  refs = packet.fetch("official_sources", []).map { |item| item["reference"] }.compact
  REQUIRED_SOURCES.all? { |source| refs.include?(source) }
end

def all_sources_verified?(packet)
  Array(packet.fetch("official_sources", []))
    .all? { |item| item["verified"] == true }
end

def all_coverage_true?(packet)
  coverage = packet.fetch("coverage_map", {})
  REQUIRED_COVERAGE_KEYS.all? { |key| coverage.fetch(key, false) == true }
end

def validate(input)
  return "DOCS_PACKET_MISSING" unless input.key?("docs_packet")

  packet = input.fetch("docs_packet")
  case input.fetch("gate", "docs_packet")
  when "docs_packet"
    return "DOCS_PACKET_MISSING_FIELDS" if packet_missing_fields?(packet)
    return "DOCS_PACKET_STATUS_MISSING" if packet.fetch("status").to_s.empty?
    return "DOCS_PACKET_BAD_STATUS" unless packet.fetch("status") == "active"
    return "DOCS_PACKET_SOURCE_MISSING" unless all_required_sources_present?(packet)
    return "DOCS_PACKET_SOURCE_NOT_VERIFIED" unless all_sources_verified?(packet)
    return "DOCS_PACKET_COVERAGE_MISSING" unless all_coverage_true?(packet)
    return "DOCS_PACKET_TASK_SCOPE_MISMATCH" if input.fetch("task_id", packet.fetch("task_id")) != packet.fetch("task_id")
    "DOCS_FIRST_GATE_PASS"
  when "behavior_claim"
    return "DOCS_PACKET_MISSING_FIELDS" if packet_missing_fields?(packet)
    return "DOCS_PACKET_BAD_STATUS" unless packet.fetch("status") == "active"
    return "DOCS_PACKET_SOURCE_MISSING" unless all_required_sources_present?(packet)
    return "DOCS_PACKET_SOURCE_NOT_VERIFIED" unless all_sources_verified?(packet)
    return "DOCS_PACKET_COVERAGE_MISSING" unless all_coverage_true?(packet)
    return "DOCS_CLAIM_WITHOUT_BEHAVIOR_SCOPE" unless input.fetch("behavior_claim", false) == true
    return "DOCS_CLAIM_NON_PROVED" if input.fetch("claim_proof_source", "none") == "requested_model"
    return "DOCS_CLAIM_NON_PROVED" if input.fetch("claim_proof_source", "none") == "resolved_model"
    return "DOCS_CLAIM_NON_PROVED" if input.fetch("claim_proof_source", "none") == "env_only"
    return "DOCS_FIRST_GATE_PASS" if input.fetch("docs_packet", {}).fetch("task_scope", "").to_s != ""
    "DOCS_CLAIM_WITHOUT_TASK_SCOPE"
  else
    "DOCS_FIRST_GATE_MISSING"
  end
end

failures = cases.filter_map do |item|
  input = item.fetch("input")
  actual = validate(input)
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
