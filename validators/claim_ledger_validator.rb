#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'fixtures/user-outcome-validation/claim-ledger-fixtures.json'
abort "missing fixture: #{path}" unless File.exist?(path)
fixture = JSON.parse(File.read(path))
errors = []

fixture.fetch('cases').each do |test|
  ledger = test.fetch('ledger')
  expect = test.fetch('expect')
  client_claims = ledger.fetch('claims').select { |c| c['audience'] == 'client' }
  unsafe = client_claims.any? { |c| %w[PARTIAL UNKNOWN RED].include?(c['verdict']) }
  missing_evidence = client_claims.any? { |c| c['verdict'] == 'GREEN' && c['evidence'].to_s.strip.empty? }
  actual = if unsafe || missing_evidence
             'UNSUPPORTED_CLIENT_CLAIM_BLOCKER'
           elsif ledger['client_facing_allowed'] == true
             'PASS'
           else
             'CLIENT_DELIVERY_NOT_ALLOWED'
           end
  errors << "#{test['name']}: expected #{expect}, got #{actual}" unless actual == expect
end

if errors.empty?
  puts JSON.pretty_generate({ status: 'PASS', validator: 'claim_ledger_validator', fixture: path })
  exit 0
end
warn JSON.pretty_generate({ status: 'FAIL', errors: errors })
exit 1
