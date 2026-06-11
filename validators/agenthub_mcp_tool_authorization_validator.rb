#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
r = JSON.parse(File.read(ARGV.fetch(0)))
errors = []
errors << 'tools_discovered missing' if Array(r['tools_discovered']).empty?
errors << 'allowed_tools missing' if Array(r['allowed_tools']).empty?
errors << 'tool_call_receipts missing' if Array(r['tool_call_receipts']).empty?
errors << 'authorization_scope missing' if r['authorization_scope'].to_s.empty?
errors << 'secret_redaction_gate must be PASS' unless r['secret_redaction_gate'] == 'PASS'
puts JSON.pretty_generate(status: errors.empty? ? 'PASS' : 'FAIL', errors: errors)
exit(errors.empty? ? 0 : 1)
