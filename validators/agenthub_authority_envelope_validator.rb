#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
failures = []
Array(doc['cases']).each do |c|
  i = c.fetch('input')
  actual = if i['lane'].to_i >= 6 && !i['owner_only_required'] && i['destructive']
             'OWNER_ONLY_IRREVERSIBLE_GATE'
           elsif Array(i['allowed_surfaces']).empty? || Array(i['allowed_operations']).empty?
             'AUTHORITY_ENVELOPE_INCOMPLETE'
           elsif Array(i['forbidden_operations']).include?(i['operation'])
             'FORBIDDEN_OPERATION_BLOCKED'
           else
             'PASS'
           end
  failures << { id: c['id'], expected: c['expected'], actual: actual } unless actual == c['expected']
end
abort(JSON.pretty_generate(status: 'FAIL', failures: failures)) unless failures.empty?
puts JSON.pretty_generate(status: 'PASS', validator: File.basename(__FILE__), cases: doc['cases'].length)
