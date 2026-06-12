#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
path = ARGV[0] || 'evals/universal-microservice-scope-broker/fixtures.json'
data = JSON.parse(File.read(path))
failures = []
Array(data['descriptors']).each do |d|
  %w[service_id service_name service_kind owner_task_id run_id environment entrypoints dependencies safe_read_surfaces repair_surfaces destructive_surfaces rollback_method validation_profile user_outcome_gate evidence_paths current_status].each do |field|
    failures << "#{d['name'] || d['service_id']}: missing #{field}" unless d.key?(field)
  end
  if d['service_kind'] == 'unknown' && d['safe_read_surfaces'].to_a.empty?
    failures << "#{d['service_id']}: unknown services require read-only discovery surfaces"
  end
  if d['destructive_surfaces'].to_a.any? && !d['requires_lane6_for_destructive']
    failures << "#{d['service_id']}: destructive surfaces require Lane 6 gate"
  end
end
abort(failures.join("\n")) unless failures.empty?
puts 'universal_microservice_scope_broker_validator: PASS'
