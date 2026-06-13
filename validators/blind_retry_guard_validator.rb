#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'fixtures/anti-blind-retry/fixtures.json'
abort "missing fixture: #{path}" unless File.exist?(path)
fixture = JSON.parse(File.read(path))
errors = []

fixture.fetch('cases').each do |test|
  attempts = test.fetch('attempts')
  expect = test.fetch('expect')
  grouped = attempts.group_by { |a| [a['gate'], a['error_signature']] }
  repeated_blind = grouped.any? do |_key, list|
    list.size > 1 && list.none? { |a| a['read_guard_source_before_retry'] || a['changed_evidence'] }
  end
  routine_gap = attempts.any? { |a| a['gate'].to_s.include?('browser') && a['error_signature'].to_s.include?('missing') }
  targeted = attempts.any? { |a| a['read_guard_source_before_retry'] && a['changed_evidence'] }

  actual = if repeated_blind
             'BLIND_RETRY_AFTER_GATE_FAIL_BLOCKER'
           elsif routine_gap && !targeted
             'CREATE_PACKFIX'
           elsif targeted
             'ALLOW_TARGETED_RETRY'
           else
             'ARCHITECTURE_DEFECT'
           end
  errors << "#{test['name']}: expected #{expect}, got #{actual}" unless actual == expect
end

if errors.empty?
  puts JSON.pretty_generate({ status: 'PASS', validator: 'blind_retry_guard_validator', fixture: path })
  exit 0
end
warn JSON.pretty_generate({ status: 'FAIL', errors: errors })
exit 1
