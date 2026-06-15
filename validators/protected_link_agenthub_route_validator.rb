#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'fixtures/protected-link-agenthub-route/fixtures.json'
fixtures = JSON.parse(File.read(path))
failures = []

APPROVED_TOOLS = %w[agent_link_read agent_link_verify agent-download packfix].freeze
BLOCKED_TOOLS = %w[web.open web.search curl wget browser_visible_only none].freeze

def actual_result(case_data)
  return 'BLOCK' if case_data['owner_handoff'] == true
  return 'BLOCK' if case_data['public_bypass'] == true
  return 'BLOCK' if BLOCKED_TOOLS.include?(case_data['allowed_tool'])
  return 'ALLOW' if case_data['allowed_tool'] == 'packfix' && case_data['packfix_created'] == true
  return 'BLOCK' unless case_data['intake_status'] == 'PASS'
  return 'BLOCK' unless APPROVED_TOOLS.include?(case_data['allowed_tool'])
  return 'BLOCK' if case_data.key?('agenthub_readback') && case_data['agenthub_readback'] != true

  'ALLOW'
end

fixtures.fetch('cases').each do |case_data|
  expected = case_data.fetch('expected')
  actual = actual_result(case_data)
  failures << "#{case_data.fetch('id')}: expected #{expected}, got #{actual}" unless actual == expected
end

if failures.empty?
  puts "PASS protected_link_agenthub_route_validator cases=#{fixtures.fetch('cases').length}"
else
  warn failures.join("\n")
  exit 1
end
