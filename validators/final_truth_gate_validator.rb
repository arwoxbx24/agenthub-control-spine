#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

path = ARGV[0] || 'fixtures/final-truth-gate/fixtures.json'
abort "missing fixture: #{path}" unless File.exist?(path)
fixture = JSON.parse(File.read(path))
errors = []

PENDING_WORDS = /pending|remaining|later|needs user|validation missing|browser missing|route missing|draft PR|blocked|partial|unknown/i
CHAT_EVIDENCE = /chatgpt|owner chat|chat text|previous draft|agent self-report/i
PR_ONLY = /pr title|pr body|github pr only|pr-only/i
LOCAL_ONLY = /curl|localhost|socket|process|pm2|systemd/i

def verdict_for(test)
  final_text = test.fetch('final_text', '')
  ledger = test['ledger']
  return 'FINAL_RESPONSE_WITHOUT_CLAIM_LEDGER' unless ledger

  if test['same_gate_retry'] == 'blind'
    return 'BLIND_RETRY_AFTER_GATE_FAIL_BLOCKER'
  elsif test['same_gate_retry'] == 'targeted_after_source_read'
    return 'PASS'
  end

  claims = ledger.fetch('claims')
  return 'FINAL_CLAIM_WITHOUT_EVIDENCE_PATH' if claims.any? { |c| c.fetch('allowed_in_final') && c.fetch('actual_evidence_path').to_s.strip.empty? }
  return 'CHATGPT_OR_OWNER_CHAT_EVIDENCE_BLOCKER' if claims.any? { |c| c.fetch('actual_evidence_path').to_s.match?(CHAT_EVIDENCE) }
  return 'PR_ONLY_PROOF_BLOCKER' if claims.any? { |c| c.fetch('actual_evidence_path').to_s.match?(PR_ONLY) }

  if ledger['user_visible_scope']
    browser_claim = claims.any? { |c| c['required_evidence_class'] == 'browser_worker_receipt' && c['evidence_readback_status'] == 'PASS' && c['verdict'] == 'GREEN' }
    local_only = claims.any? { |c| c.fetch('actual_evidence_path').to_s.match?(LOCAL_ONLY) }
    return 'LOCAL_ONLY_PROOF_BLOCKER' if local_only && !browser_claim
    return 'BROWSER_WORKER_RECEIPT_MISSING_BLOCKER' unless browser_claim
  end

  if final_text.match?(PENDING_WORDS)
    return 'STAGE_DONE_WITH_PENDING_TEXT_BLOCKER'
  end

  bad_included = claims.any? { |c| c.fetch('allowed_in_final') && (c['evidence_readback_status'] != 'PASS' || c['verdict'] != 'GREEN') }
  return 'FINAL_TEXT_WITH_UNSUPPORTED_CLAIM_BLOCKER' if bad_included

  if claims.any? { |c| %w[UNKNOWN PARTIAL RED].include?(c['verdict']) } && final_text.match?(/full|complete|done|closed|готов|закрыт|сделано/i)
    return 'CLAIM_LEDGER_NOT_GREEN_BLOCKER'
  end

  done = test['done_tuple'] || {}
  return 'DONE_EVIDENCE_TUPLE_MISSING_BLOCKER' if test['stage_done'] && %w[implementation_evidence validation_evidence receipt blocker].any? { |k| done[k].to_s.strip.empty? }
  return 'DONE_EVIDENCE_TUPLE_MISSING_BLOCKER' if test['stage_done'] && done['blocker'] != 'none'

  'PASS'
end

fixture.fetch('cases').each do |test|
  actual = verdict_for(test)
  expect = test.fetch('expect')
  errors << "#{test['name']}: expected #{expect}, got #{actual}" unless actual == expect
end

if errors.empty?
  puts JSON.pretty_generate({ status: 'PASS', validator: 'final_truth_gate_validator', fixture: path })
  exit 0
end
warn JSON.pretty_generate({ status: 'FAIL', errors: errors })
exit 1
