#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
path = ARGV[0] || 'evals/komodo-browser-outcome-truth/fixtures.json'
data = JSON.parse(File.read(path))
failures = []
Array(data['browser_receipts']).each do |r|
  next unless r['claim'] == 'site_works'
  required = r['screenshot_readable'] && r['dom_visible_markers_present'] && r['console_fatal_errors'].to_i.zero? && r['critical_network_failures'].to_i.zero?
  failures << "#{r['name']}: browser user outcome missing" unless required
end
abort(failures.join("\n")) unless failures.empty?
puts 'browser_user_outcome_validator: PASS'
