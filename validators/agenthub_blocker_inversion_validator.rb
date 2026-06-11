#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
receipt = JSON.parse(File.read(ARGV.fetch(0)))
errors = []
errors << 'routine_blockers_self_healed must be true' unless receipt['routine_blockers_self_healed'] == true
allowed_terminal = %w[OWNER_ONLY_IRREVERSIBLE_GATE SECRET_ACCESS_OWNER_REQUIRED LEGAL_OR_PAYMENT_AUTHORITY_REQUIRED GLOBAL_DESTRUCTIVE_AUTHORITY_REQUIRED MISSING_ACCOUNT_CREDENTIAL EXTERNAL_SERVICE_UNAVAILABLE_CONFIRMED SECURITY_QUARANTINE_ACTIVE INSTRUCTION_SOURCE_DRIFT]
Array(receipt['blockers']).each do |b|
  errors << "retry_limit too high: #{b['name']}" if b['retry_limit'].to_i > 2
  if b['routine'] == true && %w[SAFE_TYPED_OWNER_GATE SAFETY_HARD_STOP].include?(b['repair_action'])
    errors << "routine blocker misclassified hard stop: #{b['name']}"
  end
end
if receipt['terminal_blocker'] && !allowed_terminal.include?(receipt['terminal_blocker'])
  errors << "terminal_blocker not allowed: #{receipt['terminal_blocker']}"
end
puts JSON.pretty_generate(status: errors.empty? ? 'PASS' : 'FAIL', errors: errors)
exit(errors.empty? ? 0 : 1)
