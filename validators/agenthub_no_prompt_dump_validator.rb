#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
r = JSON.parse(File.read(ARGV.fetch(0)))
text = r['final_output_text'].to_s
errors = []
%w[Task\ Class Mission Source\ Of\ Truth Execution\ Order Required\ Schema\ Fields Validator\ Rules].each do |needle|
  errors << "prompt dump marker: #{needle}" if text.include?(needle.gsub('\\ ', ' '))
end
if r['env_only_model_claim'] == true && r['final_state'].to_s.match?(/PASS|DONE/)
  errors << 'env-only model claim cannot pass'
end
errors << 'final output must be compact' if text.length > 500
puts JSON.pretty_generate(status: errors.empty? ? 'PASS' : 'FAIL', errors: errors)
exit(errors.empty? ? 0 : 1)
