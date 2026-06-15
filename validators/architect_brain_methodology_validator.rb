#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'fixtures/architect-brain-methodology/fixtures.json'
fixtures = JSON.parse(File.read(path))
failures = []

REQUIRED_PHASES = %w[capture classify analyze triage design plan validate close].freeze
REQUIRED_GUARDS = %w[react_loop ooda reflexion_on_failure hallu_guard mutation_guard loop_watchdog].freeze

def allow_case?(case_data)
  phases = case_data.fetch('phases', [])
  guards = case_data.fetch('guards', {})
  evidence = case_data.fetch('evidence', {})

  return false unless REQUIRED_PHASES.all? { |phase| phases.include?(phase) }
  return false unless REQUIRED_GUARDS.all? { |guard| guards[guard] == true }
  return false if guards['system_policy_override_attempt'] == true

  evidence['implementation_evidence'] == true &&
    evidence['validation_evidence'] == true &&
    evidence['receipt'] == true &&
    evidence['readback'] == true
end

fixtures.fetch('cases').each do |case_data|
  expected = case_data.fetch('expected')
  actual = allow_case?(case_data) ? 'ALLOW' : 'BLOCK'
  failures << "#{case_data.fetch('id')}: expected #{expected}, got #{actual}" unless actual == expected
end

if failures.empty?
  puts "PASS architect_brain_methodology_validator cases=#{fixtures.fetch('cases').length}"
else
  warn failures.join("\n")
  exit 1
end
