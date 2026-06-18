#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
path = ARGV[0] || 'evals/komodo-browser-outcome-truth/fixtures.json'
data = JSON.parse(File.read(path))
failures = []
Array(data['cases']).each do |c|
  if c['latest_user_complaint_after_green'] && c['final_state'] == 'DONE'
    failures << "#{c['name']}: latest user complaint overrides previous green"
  end
end
abort(failures.join("\n")) unless failures.empty?
puts 'latest_user_complaint_overrides_green_validator: PASS'
