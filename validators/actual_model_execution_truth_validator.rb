#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
path = ARGV[0] || 'evals/komodo-browser-outcome-truth/fixtures.json'
data = JSON.parse(File.read(path))
failures = []
Array(data['model_receipts']).each do |r|
  next unless r['claim'] == 'codex_ran'
  proven = %w[PROVEN FALLBACK_PROVEN].include?(r['model_truth_status']) && r['actual_model'].to_s != '' && r['actual_model_proof_ref'].to_s != '' && !r['env_only_model_claim']
  failures << "#{r['name']}: env/requested/resolved-only model claim rejected" unless proven
end
abort(failures.join("\n")) unless failures.empty?
puts 'actual_model_execution_truth_validator: PASS'
