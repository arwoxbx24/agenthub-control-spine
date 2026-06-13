#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'evals/task-created-date-hardlock/fixtures.json'
abort "missing fixture: #{path}" unless File.exist?(path)
fixture = JSON.parse(File.read(path))
errors = []

def normalize_date(value)
  value.to_s.strip.sub(/T/, ' ').sub(/Z$/, '')
end

fixture.fetch('cases').each do |test|
  record = test.fetch('record')
  created_at = normalize_date(record['created_at'])
  custom_date = normalize_date(record['custom_created_date'])
  actual = if created_at.empty? && custom_date.empty?
             'BLOCKED_TASK_DATE_MISSING'
           elsif custom_date.empty?
             'BACKFILL_REQUIRED'
           elsif created_at != custom_date
             'BLOCKED_DATE_MISMATCH'
           else
             'PASS'
           end
  errors << "#{test['name']}: expected #{test['expect']}, got #{actual}" unless actual == test['expect']
end

if errors.empty?
  puts JSON.pretty_generate({ status: 'PASS', validator: 'task_created_date_hardlock_validator', fixture: path })
  exit 0
end

warn JSON.pretty_generate({ status: 'FAIL', errors: errors })
exit 1
