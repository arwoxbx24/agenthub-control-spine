#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV.fetch(0) { abort 'usage: youtrack_board_lifecycle_done_gate_validator.rb RECEIPT.json' }
receipt = JSON.parse(File.read(path))
errors = []

required = %w[
  issue_id run_id board stage_field_name stage_mapping stage_timeline
  final_stage_readback duplicate_check task_card_enrichment github_metadata
  validation_evidence receipt_path secret_redaction_gate parent_child_gate done_gate
]
required.each { |key| errors << "missing #{key}" unless receipt.key?(key) }

if receipt['final_stage_readback'] != 'Done'
  errors << 'final_stage_readback must be Done'
end

if receipt['done_gate'] != 'PASS'
  errors << 'done_gate must be PASS'
end

if receipt['secret_redaction_gate'] != 'PASS'
  errors << 'secret_redaction_gate must be PASS'
end

unless ['PASS', 'not_applicable'].include?(receipt['parent_child_gate'])
  errors << 'parent_child_gate must be PASS or not_applicable'
end

mapping = receipt['stage_mapping'] || {}
%w[Backlog Develop Review Test Done].each do |stage|
  errors << "stage_mapping missing #{stage}" if mapping[stage].to_s.empty?
end

timeline = receipt['stage_timeline'] || []
seen = timeline.map { |entry| entry['stage'] }
%w[Backlog Develop Review Test Done].each do |stage|
  errors << "stage_timeline missing #{stage}" unless seen.include?(stage)
end

enrichment = receipt['task_card_enrichment'] || {}
%w[run_id repo branch pr commit_sha receipt validation done_gate_text].each do |key|
  errors << "task_card_enrichment missing #{key}" if enrichment[key].to_s.empty?
end

duplicate = receipt['duplicate_check'] || {}
unless %w[reused_existing created_unique no_duplicate].include?(duplicate['status'])
  errors << 'duplicate_check.status invalid'
end
errors << 'duplicate_check.signature missing' if duplicate['signature'].to_s.empty?

github = receipt['github_metadata'] || {}
%w[repository branch head_sha].each do |key|
  errors << "github_metadata missing #{key}" if github[key].to_s.empty?
end

if receipt['blocker'] && !receipt['blocker'].to_s.empty?
  errors << 'active blocker present'
end

if errors.empty?
  puts JSON.pretty_generate(status: 'PASS', validator: File.basename(__FILE__), issue_id: receipt['issue_id'], final_stage_readback: receipt['final_stage_readback'])
  exit 0
end

puts JSON.pretty_generate(status: 'FAIL', validator: File.basename(__FILE__), errors: errors)
exit 1
