#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'fixtures/user-outcome-validation/fixtures.json'
abort "missing fixture: #{path}" unless File.exist?(path)
fixture = JSON.parse(File.read(path))
errors = []

PENDING_WORDS = /pending|remaining|later|needs user|validation missing|browser missing|local-only|sandbox-only|PR-only/i

fixture.fetch('cases').each do |test|
  expect = test.fetch('expect')
  matrix = test['matrix']
  done_text = test['done_text'].to_s

  if done_text.match?(PENDING_WORDS)
    actual = 'STAGE_DONE_WITH_PENDING_TEXT_BLOCKER'
  elsif matrix
    rows = matrix.fetch('rows')
    user_visible = matrix['user_visible_scope'] || matrix['browser_user_story_required']
    browser_row = rows.find { |row| row['name'] == 'browser_user_story' }
    runtime_only = matrix.dig('done_tuple', 'validation_evidence').to_s.match?(/curl|local|socket|process|pm2|systemd/i)
    actual = if user_visible && (!browser_row || browser_row['evidence_status'] != 'PASS')
               runtime_only ? 'LOCAL_ONLY_PROOF_BLOCKER' : 'BROWSER_PROOF_MISSING_BLOCKER'
             elsif matrix.dig('done_tuple', 'blocker') != 'none'
               'DONE_TUPLE_BLOCKED'
             else
               'PASS'
             end
  else
    actual = 'INVALID_FIXTURE'
  end

  errors << "#{test['name']}: expected #{expect}, got #{actual}" unless actual == expect
end

if errors.empty?
  puts JSON.pretty_generate({ status: 'PASS', validator: 'user_outcome_validation_matrix_validator', fixture: path })
  exit 0
end
warn JSON.pretty_generate({ status: 'FAIL', errors: errors })
exit 1
