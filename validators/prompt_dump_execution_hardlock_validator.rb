#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
path = ARGV[0] || 'evals/komodo-browser-outcome-truth/fixtures.json'
data = JSON.parse(File.read(path))
patterns = [/Task Class/, /Mission/, /Source Of Truth/, /Execution Order/, /Required Schema Fields/, /Validator Rules/, /Final Owner Output/]
failures = []
Array(data['final_outputs']).each do |out|
  text = out['text'].to_s
  failures << "#{out['name']}: prompt dump detected" if patterns.any? { |p| text.match?(p) }
end
abort(failures.join("\n")) unless failures.empty?
puts 'prompt_dump_execution_hardlock_validator: PASS'
