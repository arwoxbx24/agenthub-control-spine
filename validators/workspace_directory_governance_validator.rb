#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

fixture_path = ARGV[0] || 'evals/workspace-directory-governance/fixtures.json'
abort "missing fixture: #{fixture_path}" unless File.exist?(fixture_path)
fixture = JSON.parse(File.read(fixture_path))
errors = []

required_expected = %w[
  ALLOW DENY_UNREGISTERED_TEMP_PATH DENY_T0_MUTATION DENY_TASK_ID_MISSING
  DENY_RUN_ID_MISSING DENY_LIFECYCLE_MISSING DENY_AUDIT_DEFAULT_LOAD
  DENY_DONE_RECEIPT_MISSING DENY_DONE_RESIDUAL_TEXT ALLOW_DONE
  DENY_CLIENT_CLAIM_PARTIAL PACKFIX_REQUIRED DENY_BLIND_RETRY
]
seen = fixture.fetch('cases', []).map { |c| c['expected'] }
(required_expected - seen).each { |name| errors << "missing_case_#{name}" }

fixture.fetch('cases', []).each do |c|
  expected = c['expected']
  path = c['target_path'].to_s
  role = c['role'].to_s
  task_id = c['task_id'].to_s
  run_id = c['run_id'].to_s
  lifecycle = c['lifecycle'].to_s

  case expected
  when 'ALLOW'
    errors << "#{c['name']}:allow_path_not_control_spine" unless path.start_with?('@workspace/projects/agenthub-control-spine/')
    errors << "#{c['name']}:allow_missing_task" if task_id.empty?
    errors << "#{c['name']}:allow_missing_lifecycle" if lifecycle.empty?
  when 'DENY_UNREGISTERED_TEMP_PATH'
    errors << "#{c['name']}:temp_path_not_temp" unless path.include?('/tmp') || path.include?('scratch') || path.include?('final2')
  when 'DENY_T0_MUTATION'
    errors << "#{c['name']}:role_not_t0" unless role == 'T0'
  when 'DENY_TASK_ID_MISSING'
    errors << "#{c['name']}:task_not_missing" unless task_id.empty?
  when 'DENY_RUN_ID_MISSING'
    errors << "#{c['name']}:run_not_missing" unless run_id.empty?
  when 'DENY_LIFECYCLE_MISSING'
    errors << "#{c['name']}:lifecycle_not_missing" unless lifecycle.empty?
  when 'DENY_AUDIT_DEFAULT_LOAD'
    errors << "#{c['name']}:audit_default_load_not_true" unless c['lifecycle'] == 'audit_only' && c['default_load'] == true
  when 'DENY_DONE_RECEIPT_MISSING'
    markers = c.fetch('done_markers', {})
    errors << "#{c['name']}:receipt_not_missing" unless markers['Receipt'].to_s.empty?
  when 'DENY_DONE_RESIDUAL_TEXT'
    text = c.fetch('done_markers', {})['text'].to_s.downcase
    errors << "#{c['name']}:residual_text_missing" unless text.match?(/pending|remaining|later|separate|needs user|validation missing/)
  when 'ALLOW_DONE'
    markers = c.fetch('done_markers', {})
    ['Implementation evidence', 'Validation evidence', 'Receipt', 'Blocker'].each do |key|
      errors << "#{c['name']}:missing_done_marker_#{key}" if markers[key].to_s.empty?
    end
    errors << "#{c['name']}:blocker_not_none" unless markers['Blocker'].to_s.downcase == 'none'
  when 'DENY_CLIENT_CLAIM_PARTIAL'
    verdicts = c.fetch('claim_ledger', []).map { |claim| claim['verdict'] }
    errors << "#{c['name']}:no_partial_claim" unless verdicts.include?('partial') || verdicts.include?('unknown')
  when 'PACKFIX_REQUIRED'
    errors << "#{c['name']}:blocker_not_routine" unless c['blocker'].to_s.match?(/register|parser|validation|browser|stale|pr queue/i)
  when 'DENY_BLIND_RETRY'
    errors << "#{c['name']}:blind_retry_not_repeated" unless c.fetch('gate_failures', []).size >= 2 && c['evidence_changed'] == false
  end
end

if errors.empty?
  puts JSON.pretty_generate({ status: 'PASS', validator: 'workspace_directory_governance_validator', fixture: fixture_path, cases: seen.size })
  exit 0
end

warn JSON.pretty_generate({ status: 'FAIL', errors: errors })
exit 1
