#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'fixtures/scoped-test-runtime-browser-packfix/fixtures.json'
fixtures = JSON.parse(File.read(path))
TEST_URL = 'https://stroy-test.b244.ru/a/?p=banners'
PROD_BRANCHES = %w[main master].freeze
failures = []

def blocked?(c)
  return true if c['owner_message'] && c['blocker']
  return true if c['direct_shell']
  return true if c['wildcard_permission']
  return true if c['target_url'] && c['target_url'] != TEST_URL
  return true if PROD_BRANCHES.include?(c['branch'].to_s)
  return true if c['ci_green'] && c['browser_proof'] != true
  return true if c['agenthub_done'] && c['browser_proof'] != true
  return true if c['browser_proof'] && c['cleanup_done'] != true
  return true if c['code_ready'] && c['test_rollout'] == false
  return true if c['visible_result'] == 'NO_VISIBLE_RESULT'

  false
end

def allowed_positive?(c)
  return true if c['packfix'] && c['same_run'] == true && c['owner_facing'] == false
  return true if c['lane'] == 'L7_AGENTHUB_BROWSER_WORKER' && c['target_url'] == TEST_URL && c['wildcard_permission'] == false
  return true if c['browser_proof'] == true && c['target_url'] == TEST_URL && c['cleanup_done'] == true && c['production_touched'] == false && %w[BANNER_ADDED_VISIBLE AH793_ERROR_VISIBLE].include?(c['visible_result'])

  false
end

fixtures.fetch('cases').each do |c|
  actual = blocked?(c) ? 'BLOCK' : (allowed_positive?(c) ? 'ALLOW' : 'BLOCK')
  failures << "#{c.fetch('id')}: expected #{c.fetch('expected')}, got #{actual}" unless actual == c.fetch('expected')
end

if failures.empty?
  puts "PASS scoped_test_runtime_browser_packfix_validator cases=#{fixtures.fetch('cases').length}"
else
  warn failures.join("\n")
  exit 1
end
