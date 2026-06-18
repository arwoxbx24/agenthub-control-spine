#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
path = ARGV[0] || 'evals/komodo-browser-outcome-truth/fixtures.json'
data = JSON.parse(File.read(path))
failures = []
Array(data['youtrack_receipts']).each do |r|
  next unless r['stage'] == 'Done' || r['done_gate'] == 'PASS'
  ok = %w[USER_FLOW_VALIDATED KOMODO_USER_OUTCOME_VALIDATED].include?(r['evidence_quality_label']) && r['user_outcome_status'] == 'PASS'
  failures << "#{r['name']}: YouTrack Done requires user outcome proof" unless ok
end
abort(failures.join("\n")) unless failures.empty?
puts 'youtrack_done_requires_user_outcome_validator: PASS'
