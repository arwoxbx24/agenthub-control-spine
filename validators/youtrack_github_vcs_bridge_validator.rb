#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV.fetch(0) { abort 'usage: youtrack_github_vcs_bridge_validator.rb RECEIPT.json' }
receipt = JSON.parse(File.read(path))
errors = []

required = %w[
  issue_id run_id repository branch official_docs_checked integration_state
  mapping_check github_metadata_attached visibility_result secret_redaction_gate bridge_gate
]
required.each { |key| errors << "missing #{key}" unless receipt.key?(key) }

docs = receipt['official_docs_checked'] || []
if docs.length < 5 || docs.any? { |url| url !~ %r{\Ahttps://www\.jetbrains\.com/help/youtrack/} }
  errors << 'official_docs_checked must include at least five JetBrains YouTrack URLs'
end

unless %w[configured checked_existing owner_only_gate permission_blocked unavailable].include?(receipt['integration_state'])
  errors << 'integration_state invalid'
end

mapping = receipt['mapping_check'] || {}
%w[project_mapping repository_mapping webhook_state branch_references monitored_branches processing_scheme committers_group user_matching].each do |key|
  errors << "mapping_check missing #{key}" if mapping[key].to_s.empty?
end

errors << 'github_metadata_attached must be true' unless receipt['github_metadata_attached'] == true
errors << 'secret_redaction_gate must be PASS' unless receipt['secret_redaction_gate'] == 'PASS'

case receipt['bridge_gate']
when 'PASS'
  errors << 'visibility_result must prove visibility for PASS' unless %w[commit_and_pr_visible manual_metadata_visible].include?(receipt['visibility_result'])
  errors << 'owner_only_gate must be empty for PASS' unless receipt['owner_only_gate'].nil? || receipt['owner_only_gate'].to_s.empty?
when 'OWNER_ONLY_GATED'
  allowed = %w[OWNER_ONLY_GITHUB_YOUTRACK_TOKEN_GATE YOUTRACK_VCS_INTEGRATION_PERMISSION_MISSING GITHUB_REPOSITORY_ADMIN_PERMISSION_MISSING VCS_WEBHOOK_UNAVAILABLE]
  errors << 'owner_only_gate must be typed' unless allowed.include?(receipt['owner_only_gate'])
else
  errors << 'bridge_gate invalid'
end

%w[repository branch].each { |key| errors << "#{key} missing" if receipt[key].to_s.empty? }

if errors.empty?
  puts JSON.pretty_generate(status: 'PASS', validator: File.basename(__FILE__), issue_id: receipt['issue_id'], bridge_gate: receipt['bridge_gate'])
  exit 0
end

puts JSON.pretty_generate(status: 'FAIL', validator: File.basename(__FILE__), errors: errors)
exit 1
