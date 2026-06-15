#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'fixtures/owner-input-validation-priority-guard/fixtures.json'
fixtures = JSON.parse(File.read(path))
failures = []

VALID_CLASSES = %w[
  SAFE_DIRECT_ACTION NEEDS_SCOPE_NARROWING EMOTIONAL_INCIDENT_SIGNAL
  UNSAFE_OR_HARMFUL_REQUEST CONFLICTS_WITH_PROJECT_HIERARCHY
  PRODUCTION_OR_IRREVERSIBLE_GATE BROAD_PERMISSION_REQUEST
  COMMUNICATION_PREFERENCE EVIDENCE_OR_LINK_FACT_CLAIM AMBIGUOUS_TASK_DATA
].freeze

VALID_DECISIONS = %w[ALLOW NARROW REJECT_UNSAFE_PART OWNER_ONLY_GATE PACKFIX BLOCK_FAKE_DONE].freeze

def scoped_lane?(lane)
  return false unless lane.is_a?(Hash)

  %w[task_id run_id repo path tool operation expiry rollback evidence].all? { |key| lane[key].to_s.strip != '' }
end

def allowed_case?(case_data)
  classification = case_data.fetch('classification')
  decision = case_data.fetch('decision')

  return false unless VALID_CLASSES.include?(classification)
  return false unless VALID_DECISIONS.include?(decision)
  return false if case_data['fake_done'] == true
  return false if case_data['local_only_closure'] == true
  return false if case_data['owner_shell_handoff'] == true
  return false if case_data['has_internal_logs'] == true
  return false if case_data['owner_claim_is_proof'] == true

  if classification == 'UNSAFE_OR_HARMFUL_REQUEST'
    return decision == 'REJECT_UNSAFE_PART'
  end

  if classification == 'BROAD_PERMISSION_REQUEST'
    return decision == 'NARROW' && scoped_lane?(case_data['permission_lane'])
  end

  if classification == 'COMMUNICATION_PREFERENCE'
    msg = case_data['action_bound_message'].to_s
    return false if msg.empty?
    return false unless msg.start_with?('Факт: ', 'Действие: ', 'Нужен владелец: ', 'Готово: ')
  end

  if decision == 'ALLOW'
    return case_data['implementation_evidence'] == true &&
           case_data['validation_evidence'] == true &&
           case_data['receipt'] == true &&
           case_data['readback'] == true
  end

  %w[NARROW REJECT_UNSAFE_PART OWNER_ONLY_GATE PACKFIX].include?(decision)
end

fixtures.fetch('cases').each do |case_data|
  expected = case_data.fetch('expected')
  actual = allowed_case?(case_data) ? 'ALLOW' : 'BLOCK'
  failures << "#{case_data.fetch('id')}: expected #{expected}, got #{actual}" unless actual == expected
end

if failures.empty?
  puts "PASS owner_input_validation_priority_guard_validator cases=#{fixtures.fetch('cases').length}"
else
  warn failures.join("\n")
  exit 1
end
