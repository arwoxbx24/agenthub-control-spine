#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'fixtures/owner-output-hardlock/fixtures.json'
fixtures = JSON.parse(File.read(path))
failures = []

FORBIDDEN_FRAGMENTS = [
  'Статус: blocked',
  'Осталось',
  'я остановился',
  'вставь команду',
  'не могу',
  'нужно включить worker',
  'PR готов, но',
  'factcheck:'
].freeze

ALLOWED_PREFIXES = {
  'SUCCESS' => 'Готово: ',
  'ACTION' => 'Действие: ',
  'OWNER_ONLY_GATE' => 'Нужен владелец: '
}.freeze

def one_line?(message)
  !message.include?("\n") && message.length <= 220
end

def forbidden_fragment?(message)
  normalized = message.downcase
  FORBIDDEN_FRAGMENTS.any? { |fragment| normalized.include?(fragment.downcase) }
end

def allow_success?(evidence)
  evidence['implementation_evidence'] == true &&
    evidence['validation_evidence'] == true &&
    evidence['receipt'] == true &&
    evidence['readback'] == true &&
    evidence['active_blocker'] == false &&
    evidence['same_scope_tail'] == false
end

def allow_action?(evidence)
  evidence['autonomous_action_available'] == true
end

def allow_owner_gate?(evidence)
  evidence['owner_only_irreversible_gate'] == true
end

def actual_result(case_data)
  message = case_data.fetch('message')
  classification = case_data.fetch('classification')
  evidence = case_data.fetch('evidence', {})

  return 'BLOCK' unless one_line?(message)
  return 'BLOCK' if forbidden_fragment?(message)
  return 'BLOCK' unless ALLOWED_PREFIXES.key?(classification)
  return 'BLOCK' unless message.start_with?(ALLOWED_PREFIXES.fetch(classification))

  allowed = case classification
            when 'SUCCESS'
              allow_success?(evidence)
            when 'ACTION'
              allow_action?(evidence)
            when 'OWNER_ONLY_GATE'
              allow_owner_gate?(evidence)
            else
              false
            end

  allowed ? 'ALLOW' : 'BLOCK'
end

fixtures.fetch('cases').each do |case_data|
  expected = case_data.fetch('expected')
  actual = actual_result(case_data)
  failures << "#{case_data.fetch('id')}: expected #{expected}, got #{actual}" unless actual == expected
end

if failures.empty?
  puts "PASS owner_output_hardlock_validator cases=#{fixtures.fetch('cases').length}"
else
  warn failures.join("\n")
  exit 1
end
