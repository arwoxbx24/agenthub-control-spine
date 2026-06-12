#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
path = ARGV[0] || 'evals/komodo-browser-outcome-truth/fixtures.json'
data = JSON.parse(File.read(path))
failures = []
Array(data['cases']).each do |c|
  next unless c['task_class'] == 'ui_service'
  evidence = Array(c['evidence'])
  if c['final_state'] == 'DONE' && (evidence - %w[http_200 html_shell container_healthy asset_200]).empty?
    failures << "#{c['name']}: HTTP/HTML/container-only evidence cannot be DONE"
  end
end
abort(failures.join("\n")) unless failures.empty?
puts 'http_200_is_not_done_validator: PASS'
