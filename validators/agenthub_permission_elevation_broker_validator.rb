#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
r = JSON.parse(File.read(ARGV.fetch(0)))
errors = []
%w[task_id run_id lane tool_name operation allowed_scope forbidden_scope receipt_path secret_redaction_gate].each { |k| errors << "missing #{k}" if r[k].to_s.empty? }
errors << 'secret_redaction_gate must be PASS' unless r['secret_redaction_gate'] == 'PASS'
if r['allowed_scope'].to_s.match?(/global (shell|docker|db|firewall|secret|network)/i)
  errors << 'global dangerous scope denied'
end
if r['lane'].to_i == 6 && r['rollback_requirement'].to_s.empty?
  errors << 'lane 6 requires rollback or irreversible proof'
end
puts JSON.pretty_generate(status: errors.empty? ? 'PASS' : 'FAIL', errors: errors)
exit(errors.empty? ? 0 : 1)
