#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'fixtures/owner-output-solution-only-hardlock/fixtures.json'
fixtures = JSON.parse(File.read(path))
failures = []

def allowed_output?(case_data)
  message = case_data.fetch('message').to_s
  klass = case_data.fetch('class')

  return false if case_data['routine_blocker_final'] == true
  return false if case_data['status_only'] == true
  return false if case_data['apology_loop'] == true
  return false if case_data['fake_done'] == true

  case klass
  when 'SUCCESS'
    message.start_with?('Готово: ') &&
      case_data['implementation_evidence'] == true &&
      case_data['validation_evidence'] == true &&
      case_data['receipt'] == true &&
      case_data['readback'] == true &&
      case_data['no_active_blocker'] == true
  when 'ACTION'
    message.start_with?('Действие: ') && case_data['autonomous_action'] == true
  when 'OWNER_ONLY_GATE'
    message.start_with?('Нужен владелец: ') && case_data['owner_only_gate_proven'] == true
  else
    false
  end
end

fixtures.fetch('cases').each do |case_data|
  expected = case_data.fetch('expected')
  actual = allowed_output?(case_data) ? 'ALLOW' : 'BLOCK'
  failures << "#{case_data.fetch('id')}: expected #{expected}, got #{actual}" unless actual == expected
end

if failures.empty?
  puts "PASS owner_output_solution_only_hardlock_validator cases=#{fixtures.fetch('cases').length}"
else
  warn failures.join("\n")
  exit 1
end
