#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
failures = []
Array(doc['cases']).each do |c|
  i = c.fetch('input')
  actual = if !i['issue_id_in_branch'] || !i['issue_id_in_commit_or_pr']
             'GITHUB_YOUTRACK_BINDING_FAILED'
           elsif i['integration_required'] && !i['youtrack_activity_stream_verified'] && i['integration_blocker'].to_s.empty?
             'YOUTRACK_GITHUB_INTEGRATION_MISSING'
           else
             'PASS'
           end
  failures << { id: c['id'], expected: c['expected'], actual: actual } unless actual == c['expected']
end
abort(JSON.pretty_generate(status: 'FAIL', failures: failures)) unless failures.empty?
puts JSON.pretty_generate(status: 'PASS', validator: File.basename(__FILE__), cases: doc['cases'].length)
