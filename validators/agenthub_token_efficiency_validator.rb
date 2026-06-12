#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
failures = []
Array(doc['cases']).each do |c|
  i = c.fetch('input')
  actual = if i.fetch('prompt_dump_count', 0).positive?
             'NO_PROMPT_DUMP_FAILED'
           elsif i.fetch('same_blocker_retry_count', 0).to_i > 2
             'SAME_GATE_RETRY_LIMIT_FAILED'
           elsif i.fetch('reduction_percent', 0).to_f < 25
             'TOKEN_EFFICIENCY_PACKFIX_REQUIRED'
           else
             'PASS'
           end
  failures << { id: c['id'], expected: c['expected'], actual: actual } unless actual == c['expected']
end
abort(JSON.pretty_generate(status: 'FAIL', failures: failures)) unless failures.empty?
puts JSON.pretty_generate(status: 'PASS', validator: File.basename(__FILE__), cases: doc['cases'].length)
