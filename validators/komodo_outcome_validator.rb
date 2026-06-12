#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
path = ARGV[0] || 'evals/komodo-browser-outcome-truth/fixtures.json'
data = JSON.parse(File.read(path))
failures = []
Array(data['komodo_receipts']).each do |r|
  next unless r['claim'] == 'komodo_works'
  required = r['public_route_status'] == 'PASS' && r['browser_render_status'] == 'BROWSER_RENDERED' && %w[PASS LOGIN_SCREEN_ONLY].include?(r['login_or_dashboard_status']) && r['api_status'] != 'FAIL' && r['komodo_user_outcome_status'] == 'PASS'
  failures << "#{r['name']}: Komodo user outcome not proven" unless required
end
abort(failures.join("\n")) unless failures.empty?
puts 'komodo_outcome_validator: PASS'
