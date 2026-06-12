#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
path = ARGV[0] || 'evals/komodo-browser-outcome-truth/fixtures.json'
data = JSON.parse(File.read(path))
failures = []
Array(data['route_receipts']).each do |r|
  next unless r['claim'] == 'agenthub_worker_executed'
  proven = r['route_truth_status'] == 'PROVEN' && %w[agenthub_mcp_dispatch agenthub_mcp_execute github_control_spine_api].include?(r['route_type']) && r['mcp_tool_call_id_or_agenthub_dispatch_id'].to_s != ''
  failures << "#{r['name']}: shell/env-only route proof rejected" unless proven
end
abort(failures.join("\n")) unless failures.empty?
puts 'actual_agenthub_route_validator: PASS'
