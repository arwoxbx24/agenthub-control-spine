#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
r = JSON.parse(File.read(ARGV.fetch(0)))
errors = []
errors << 'final_stage must be Done' unless r['final_stage'] == 'Done'
errors << 'done_gate must be PASS' unless r['done_gate'] == 'PASS'
errors << 'evidence_present must be true' unless r['evidence_present'] == true
seen = Array(r['stage_timeline']).map { |x| x['stage'] }
%w[Develop Review Test Done].each { |s| errors << "missing stage #{s}" unless seen.include?(s) }
puts JSON.pretty_generate(status: errors.empty? ? 'PASS' : 'FAIL', errors: errors)
exit(errors.empty? ? 0 : 1)
