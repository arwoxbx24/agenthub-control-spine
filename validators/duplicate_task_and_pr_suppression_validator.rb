#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
path = ARGV[0] || 'evals/komodo-browser-outcome-truth/fixtures.json'
data = JSON.parse(File.read(path))
seen = {}
failures = []
Array(data['contours']).each do |c|
  sig = c['duplicate_signature']
  next if sig.to_s.empty?
  if seen[sig] && c['created_new_task_or_pr']
    failures << "#{c['name']}: duplicate task/PR must be suppressed for #{sig}"
  end
  seen[sig] = true
end
abort(failures.join("\n")) unless failures.empty?
puts 'duplicate_task_and_pr_suppression_validator: PASS'
