#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

fixture_path = ARGV[0] || 'evals/agenthub-universal-infrastructure-scope-broker/fixtures.json'
abort "missing fixture: #{fixture_path}" unless File.exist?(fixture_path)

fixture = JSON.parse(File.read(fixture_path))
errors = []

positive = fixture.fetch('positive_cases', [])
negative = fixture.fetch('negative_cases', [])

errors << 'positive_cases_missing' if positive.empty?
errors << 'negative_cases_missing' if negative.empty?

positive.each do |case_item|
  if (descriptor = case_item['descriptor'])
    %w[service_id project_root component_type task_id run_id allowed_operations forbidden_operations required_evidence].each do |field|
      errors << "descriptor_#{case_item['name']}_missing_#{field}" unless descriptor.key?(field)
    end
  end

  if (packfix = case_item['packfix'])
    errors << "packfix_#{case_item['name']}_not_routine" unless packfix['routine_or_owner_only'] == 'routine'
    errors << "packfix_#{case_item['name']}_attempt_out_of_range" unless (1..2).include?(packfix['attempt_number'].to_i)
  end
end

required_negative = %w[SERVICE_SPECIFIC_POLICY_LEAK HTTP_200_ONLY_EVIDENCE ARCHITECTURE_REPAIR_REQUIRED NO_RAW_SECRET_OUTPUT_FAIL]
seen_negative = negative.map { |item| item['expected_failure'] }
(required_negative - seen_negative).each { |missing| errors << "missing_negative_case_#{missing}" }

if errors.empty?
  puts JSON.pretty_generate({ status: 'PASS', validator: 'agenthub_universal_infrastructure_scope_broker_validator', fixture: fixture_path })
  exit 0
end

warn JSON.pretty_generate({ status: 'FAIL', errors: errors })
exit 1
