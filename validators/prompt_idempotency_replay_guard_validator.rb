#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

fixture_path = ARGV[0] || 'evals/prompt-idempotency-replay-guard/fixtures.json'
abort "missing fixture: #{fixture_path}" unless File.exist?(fixture_path)

fixture = JSON.parse(File.read(fixture_path))
errors = []

frontmatter = fixture.fetch('valid_frontmatter', {})
required_frontmatter = %w[artifact_id artifact_type prompt_uid prompt_family idempotency_key_template source_task run_id scope_signature owner_role lifecycle_status default_load safe_to_replay created_at]
(required_frontmatter - frontmatter.keys).each { |field| errors << "missing_frontmatter_#{field}" }

template = frontmatter['idempotency_key_template'].to_s
%w[prompt_uid source_task scope_signature repo target_branch artifact_paths_hash].each do |part|
  errors << "idempotency_template_missing_#{part}" unless template.include?(part)
end

records = fixture.fetch('records', [])
expected_decisions = %w[NEW_EXECUTION_ALLOWED PROMPT_ALREADY_EXECUTED_NO_REPLAY SAME_PROMPT_RESUME_FROM_RESIDUAL_PACKFIX STALE_PROMPT_REPLAY_DENIED_SUPERSEDED]
seen = records.map { |record| record['replay_decision'] }
(expected_decisions - seen).each { |decision| errors << "missing_decision_#{decision}" }

records.each do |record|
  if record['replay_decision'] == 'PROMPT_ALREADY_EXECUTED_NO_REPLAY' && record['mutation_decision'] != 'NOOP'
    errors << 'duplicate_replay_must_noop'
  end
  if record['replay_decision'] == 'SAME_PROMPT_RESUME_FROM_RESIDUAL_PACKFIX' && record['mutation_decision'] != 'RESUME'
    errors << 'partial_replay_must_resume'
  end
end

negative_cases = fixture.fetch('negative_cases', [])
%w[missing_prompt_uid missing_idempotency_key_template duplicate_replay_mutates old_prompt_overwrites_newer_control prompt_text_only_final].each do |name|
  errors << "missing_negative_case_#{name}" unless negative_cases.include?(name)
end

if errors.empty?
  puts JSON.pretty_generate({ status: 'PASS', validator: 'prompt_idempotency_replay_guard_validator', fixture: fixture_path })
  exit 0
end

warn JSON.pretty_generate({ status: 'FAIL', errors: errors })
exit 1
