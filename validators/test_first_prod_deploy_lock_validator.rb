#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'fixtures/test-first-prod-deploy-lock/fixtures.json'
fixtures = JSON.parse(File.read(path))
failures = []

EXACT_PROD_PHRASE = 'разрешаю отгрузку на прод'
PROD_BRANCHES = %w[main master].freeze
PROD_ENVS = %w[PRODUCTION UNKNOWN_PROD_RISK].freeze

def expected_block?(case_data)
  action = case_data.fetch('action')
  route = case_data.fetch('route', {})
  workflow = case_data.fetch('workflow', {})
  approval = case_data.fetch('approval', {})
  evidence = case_data.fetch('evidence', {})

  branch = route['target_branch'] || workflow['current_branch']
  environment = route['target_environment'] || 'UNKNOWN_PROD_RISK'
  conclusion = route['conclusion'] || workflow['conclusion']

  return true if PROD_BRANCHES.include?(branch) && %w[merge workflow_run deploy push].include?(action)
  return true if PROD_ENVS.include?(environment)
  return true if conclusion == 'UNKNOWN_IS_PROD_RISK'
  return true if route['production_workflow_can_trigger'] == true
  return true if route['production_secrets_can_access'] == true
  return true if workflow['yaml_read'] == false
  return true if workflow['can_trigger_production'] == true
  return true if action == 'production_release' && approval['owner_phrase'] != EXACT_PROD_PHRASE
  return true if action == 'production_release' && evidence['test_contour_passed'] != true
  return true if action == 'production_release' && evidence['browser_or_owner_acceptance_passed'] != true
  return true if action == 'done_claim' && evidence['browser_or_owner_acceptance_passed'] != true
  return true if action == 'client_delivery_claim' && evidence['claim_ledger_green'] != true
  return true if action == 'emergency_rollback' && evidence['previous_known_good_proof'] != true
  return true if action == 'branch_cleanup' && evidence['register_evidence'] != true

  false
end

fixtures.fetch('cases').each do |case_data|
  expected = case_data.fetch('expected')
  actual = expected_block?(case_data) ? 'BLOCK' : 'ALLOW'
  failures << "#{case_data.fetch('id')}: expected #{expected}, got #{actual}" unless actual == expected
end

if failures.empty?
  puts "PASS test_first_prod_deploy_lock_validator cases=#{fixtures.fetch('cases').length}"
else
  warn failures.join("\n")
  exit 1
end
