#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
path = ARGV[0] || 'evals/universal-microservice-scope-broker/fixtures.json'
data = JSON.parse(File.read(path))
weak = %w[http_200 container_running healthy_container html_shell env_model screenshot_only local_only sandbox_only github_pr_only task_created_only]
failures = []
Array(data['done_cases']).each do |c|
  evidence = Array(c['evidence'])
  if c['final_state'] == 'DONE' && (evidence - weak).empty?
    failures << "#{c['name']}: weak evidence cannot be Done"
  end
  if c['final_state'] == 'DONE' && c['user_facing'] && !evidence.include?('user_outcome_proof')
    failures << "#{c['name']}: user-facing Done requires user outcome proof"
  end
  if c['final_state'] == 'DONE' && c['youtrack_stage'] != 'Done'
    failures << "#{c['name']}: Done requires YouTrack Stage=Done readback"
  end
  if c['final_state'] == 'DONE' && c['open_packfix_count'].to_i.positive?
    failures << "#{c['name']}: Done forbidden with open PackFix"
  end
end
abort(failures.join("\n")) unless failures.empty?
puts 'runtime_done_truth_validator: PASS'
