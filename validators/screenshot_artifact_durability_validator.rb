#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
path = ARGV[0] || 'evals/komodo-browser-outcome-truth/fixtures.json'
data = JSON.parse(File.read(path))
failures = []
Array(data['browser_receipts']).each do |r|
  next unless r['requires_screenshot']
  ok = r['screenshot_path'].to_s != '' && r['screenshot_sha256'].to_s.match?(/\A[a-f0-9]{64}\z/) && r['screenshot_readable']
  failures << "#{r['name']}: screenshot artifact missing or unreadable" unless ok
end
abort(failures.join("\n")) unless failures.empty?
puts 'screenshot_artifact_durability_validator: PASS'
