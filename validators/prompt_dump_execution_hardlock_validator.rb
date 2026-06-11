#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV.fetch(0) { abort 'usage: prompt_dump_execution_hardlock_validator.rb RECEIPT.json' }
receipt = JSON.parse(File.read(path))
errors = []

required = %w[
  task_id run_id duplicate_check prompt_dump_detected prompt_executed_as_contract
  implementation_evidence validation_evidence receipt_path final_output_shape
  youtrack_stage_readback done_gate secret_redaction_gate
]
required.each { |key| errors << "missing #{key}" unless receipt.key?(key) }

errors << 'prompt_executed_as_contract must be true' unless receipt['prompt_executed_as_contract'] == true
errors << 'secret_redaction_gate must be PASS' unless receipt['secret_redaction_gate'] == 'PASS'

if receipt['done_gate'] == 'PASS'
  errors << 'youtrack_stage_readback must be Done for PASS' unless receipt['youtrack_stage_readback'] == 'Done'
  errors << 'blocker must be empty for PASS' unless receipt['blocker'].nil? || receipt['blocker'].to_s.empty?
end

final_text = receipt['final_output_text'].to_s
forbidden = [
  'Task Class', 'Mission', 'Source Of Truth', 'Execution Order',
  'Required Schema Fields', 'Validator Rules', 'Final Owner Output',
  'below are corrected blocks', 'copy/paste this prompt'
]
forbidden.each do |needle|
  errors << "prompt dump marker present: #{needle}" if final_text.include?(needle)
end

Array(receipt['implementation_evidence']).each do |entry|
  errors << 'raw prompt body stored as implementation evidence' if entry.include?('## Mission') && entry.include?('## Execution Order')
end

if errors.empty?
  puts JSON.pretty_generate(status: 'PASS', validator: File.basename(__FILE__), task_id: receipt['task_id'])
  exit 0
end

puts JSON.pretty_generate(status: 'FAIL', validator: File.basename(__FILE__), errors: errors)
exit 1
