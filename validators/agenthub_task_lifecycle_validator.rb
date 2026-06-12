#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
failures = []
Array(doc['cases']).each do |c|
  input = c.fetch('input')
  expected = c.fetch('expected')
  actual = if input['duplicate_check'] != 'PASS'
             'DUPLICATE_TASK_GATE_FAILED'
           elsif input['stage'] == 'Backlog' && input['work_started']
             'TASK_GARBAGE_DEFECT'
           elsif input['stage'] == 'Done' && input['done_gate'] != 'PASS'
             'DONE_GATE_BLOCKED'
           elsif input['stage'] == 'Done' && input.fetch('children_open', 0).to_i.positive? && !input['tracking_parent']
             'OPEN_CHILD_TASKS_BLOCK_DONE'
           else
             'PASS'
           end
  failures << { id: c['id'], expected: expected, actual: actual } unless actual == expected
end
abort(JSON.pretty_generate(status: 'FAIL', failures: failures)) unless failures.empty?
puts JSON.pretty_generate(status: 'PASS', validator: File.basename(__FILE__), cases: doc['cases'].length)
