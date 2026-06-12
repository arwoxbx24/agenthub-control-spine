#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
SELF_HEAL = %w[TASK_GARBAGE_DEFECT YOUTRACK_STAGE_READBACK_REPAIR_REQUIRED DOCS_ACQUISITION_PACKFIX_REQUIRED LOCAL_PROJECT_GUIDE_MISSING SERVICE_DESCRIPTOR_MISSING RUNTIME_TOOL_INSTALLATION_REQUIRED VALIDATOR_EXECUTION_NOT_RUN CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED YOUTRACK_READBACK_PERMISSION_MISSING PUBLIC_ROUTE_FAILURE REGISTER_INDEX_PR_QUEUE_UPDATE_PENDING TOKEN_EFFICIENCY_PACKFIX_REQUIRED]
path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
failures = []
Array(doc['cases']).each do |c|
  i = c.fetch('input')
  actual = if SELF_HEAL.include?(i['blocker']) && i.fetch('attempts', 0).to_i < 2
             'PACKFIX_REQUIRED'
           elsif SELF_HEAL.include?(i['blocker'])
             'SAME_GATE_LOOP_LIMIT_REACHED'
           else
             'OWNER_ONLY_OR_DONE'
           end
  failures << { id: c['id'], expected: c['expected'], actual: actual } unless actual == c['expected']
end
abort(JSON.pretty_generate(status: 'FAIL', failures: failures)) unless failures.empty?
puts JSON.pretty_generate(status: 'PASS', validator: File.basename(__FILE__), cases: doc['cases'].length)
