#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'

ROUTINE = {
  'CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED' => 'PACKFIX_INSTALL_OR_AUTHORIZE_LIVE_READ_WORKER_ROUTE',
  'RUNTIME_TOOL_INSTALLATION_REQUIRED' => 'PACKFIX_INSTALL_VALIDATOR_EXECUTION_ROUTE',
  'LIVE_WORKER_AUTHORITY_MISSING_AFTER_PACKFIX' => 'PACKFIX_INSTALL_OR_AUTHORIZE_LIVE_REPAIR_WORKER_ROUTE',
  'VALIDATOR_EXECUTION_NOT_RUN' => 'PACKFIX_INSTALL_VALIDATOR_EXECUTION_ROUTE',
  'REGISTER_APPEND_ROUTE_PENDING' => 'PACKFIX_INSTALL_REGISTER_SAFE_APPEND_ROUTE',
  'PR_QUEUE_UPDATE_PENDING' => 'PACKFIX_INSTALL_REGISTER_SAFE_APPEND_ROUTE',
  'INDEX_REGISTER_UPDATE_PENDING' => 'PACKFIX_INSTALL_REGISTER_SAFE_APPEND_ROUTE',
  'YOUTRACK_READBACK_PERMISSION_MISSING' => 'PACKFIX_TASK_STAGE_GOVERNOR_REPAIR',
  'PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID' => 'PACKFIX_INJECT_TASK_CONTEXT_TO_SHELL_GUARD',
  'MODEL_FALLBACK_RECEIPT_MISSING' => 'PACKFIX_INSTALL_MODEL_TRUTH_PROBE',
  'PUBLIC_ROUTE_FAILURE' => 'PACKFIX_INSTALL_BROWSER_OUTCOME_WORKER',
  'UI_BACKEND_BROWSER_USER_PROOF_MISSING' => 'PACKFIX_INSTALL_BROWSER_OUTCOME_WORKER'
}.freeze

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
failures = []
Array(doc['cases']).each do |c|
  i = c.fetch('input')
  actual = if i['blocker'] == 'NO_BLOCKER' && i['done_gate'] == 'PASS'
             'DONE_WITH_EVIDENCE'
           elsif i.fetch('attempt', 1).to_i > 2 && ROUTINE.key?(i['blocker'])
             'SAME_GATE_LOOP_LIMIT_REACHED'
           elsif i['owner_only_required'] || i['lane'].to_i == 7
             'OWNER_ONLY_IRREVERSIBLE_GATE'
           elsif ROUTINE.key?(i['blocker'])
             ROUTINE.fetch(i['blocker'])
           else
             'FORBIDDEN_SCOPE_OUTSIDE_CONTOUR'
           end
  failures << { id: c['id'], expected: c['expected'], actual: actual } unless actual == c['expected']
end
abort(JSON.pretty_generate(status: 'FAIL', failures: failures)) unless failures.empty?
puts JSON.pretty_generate(status: 'PASS', validator: File.basename(__FILE__), cases: doc['cases'].length)
