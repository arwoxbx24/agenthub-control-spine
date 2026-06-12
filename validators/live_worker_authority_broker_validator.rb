#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'evals/live-worker-authority-broker/fixtures.json'
data = JSON.parse(File.read(path))
routine_terminal_forbidden = %w[
  LIVE_WORKER_AUTHORITY_MISSING_AFTER_PACKFIX
  CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED
  NO_APPROVED_WORKER_ROUTE_AFTER_REPAIR
  T0_DIRECT_RUNTIME_MUTATION_DEFECT
  T0_DIRECT_AUTHORSHIP_DEFECT
  MODEL_FALLBACK_RECEIPT_MISSING
  DUPLICATE_PROGRESS_OUTPUT_BLOCKED
  PUBLIC_ROUTE_FAILURE
  UI_BACKEND_BROWSER_USER_PROOF_MISSING
  TASK_SERVICE_READBACK_MISSING
  INDEX_REGISTER_PR_QUEUE_UPDATE_PENDING
  VALIDATOR_EXECUTION_NOT_RUN
]
terminal_owner_only = %w[
  OWNER_ONLY_IRREVERSIBLE_GATE
  MISSING_ACCOUNT_CREDENTIAL_NO_AGENT_CAN_ACCESS
  LEGAL_OR_PAYMENT_GATE
  EXPLICIT_DESTRUCTIVE_OWNER_CONFIRMATION_REQUIRED
  SECRET_ACCESS_NOT_DELEGABLE
  SCOPE_CONFLICT_UNSAFE_TO_AUTOREPAIR
]
failures = []

Array(data['cases']).each do |c|
  sig = c['blocker_signature']
  if routine_terminal_forbidden.include?(sig)
    failures << "#{c['name']}: routine blocker must create PackFix" unless c['packfix_created']
    failures << "#{c['name']}: routine blocker must invoke Authority Broker" unless c['authority_broker_invoked']
    failures << "#{c['name']}: routine blocker cannot be final blocker" if c['final_blocker_allowed']
  end
  if c['same_signature_count'].to_i >= 3 && c['routine_blocker']
    failures << "#{c['name']}: third same-gate retry forbidden"
  end
  if terminal_owner_only.include?(sig) && c['decision'] != 'OWNER_ONLY'
    failures << "#{c['name']}: owner-only blocker must not be silently scoped"
  end
end

Array(data['grants']).each do |g|
  %w[task_id run_id packfix_id blocker_signature lane worker_role allowed_surfaces forbidden_surfaces grant_scope receipt_path decision].each do |field|
    failures << "grant #{g['packfix_id'] || 'unknown'} missing #{field}" unless g.key?(field)
  end
  if g['lane'].to_i == 6 && g['decision'] == 'ALLOW_SCOPED'
    failures << "grant #{g['packfix_id']}: Lane 6 cannot be scoped without owner/destruction proof"
  end
  forbidden = Array(g['forbidden_surfaces']).map(&:downcase)
  if forbidden.none? { |s| s.include?('secret') }
    failures << "grant #{g['packfix_id']}: forbidden secret surface must be explicit"
  end
end

abort(failures.join("\n")) unless failures.empty?
puts 'live_worker_authority_broker_validator: PASS'
