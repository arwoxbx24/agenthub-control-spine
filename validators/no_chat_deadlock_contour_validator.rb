#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

FORBIDDEN_PATH_PREFIXES = [
  "/root/gemini-space",
  "/root/codex-space",
  "/tmp"
].freeze

FINAL_PATTERN = /\AFact: .+\nAction: .+\nLeft: (none|[A-Z0-9_]+)\z/

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def missing?(input, fields)
  fields.any? { |field| blank?(input[field]) }
end

def forbidden_path?(path)
  FORBIDDEN_PATH_PREFIXES.any? { |prefix| path.to_s == prefix || path.to_s.start_with?("#{prefix}/") }
end

def route(input)
  case input.fetch("gate")
  when "no_mid_cycle_user_chat"
    return "USER_CHAT_STOP_DEFECT" if input["state"] == "ACTIVE_RUN" &&
                                      input["user_facing_progress"] == true
    "NO_MID_CYCLE_USER_CHAT_PASS"

  when "user_delta_queue"
    return "USER_DELTA_QUEUE_MISSING" if input["state"] == "ACTIVE_RUN" &&
                                         input["user_message_received"] == true &&
                                         input["delta_queued"] != true
    return "USER_DELTA_STOP_DEFECT" if input["delta_classification"] != "OWNER_ONLY_GATE" &&
                                      input["stops_active_worker"] == true
    "USER_DELTA_QUEUE_PASS"

  when "tz_before_mutation"
    required = %w[task_id run_id tz scope allowed_paths forbidden_paths rollback validation]
    return "TZ_BEFORE_MUTATION_BLOCKED" if input["mutation_requested"] == true && missing?(input, required)
    "TZ_BEFORE_MUTATION_PASS"

  when "forbidden_directory"
    paths = Array(input["changed_paths"]) + Array(input["evidence_paths"])
    return "FORBIDDEN_SCOPE_TOUCH" if paths.any? { |path| forbidden_path?(path) } &&
                                      input["explicit_canonical_target"] != true
    "FORBIDDEN_DIRECTORY_PASS"

  when "live_path_proof"
    return "LIVE_PATH_NOT_PROVEN" if input["implementation_claim"] == true &&
                                     input["live_path_proof"] != "PASS" &&
                                     input["repo_canonical"] != true
    "LIVE_PATH_PROOF_PASS"

  when "deadlock_breaker"
    return "DEADLOCK_RETRY_LIMIT_REACHED" if input.fetch("same_gate_failures", 0).to_i >= 2 &&
                                             input["third_identical_retry"] == true
    return "CONTEXT_BLOAT_DEFECT" if input.fetch("context_window_failures", 0).to_i >= 2 &&
                                     input["same_huge_prompt_retry"] == true
    "DEADLOCK_BREAKER_PASS"

  when "model_route_receipt"
    return "MODEL_ROUTE_MISMATCH" if input["requested_model"] != input["actual_model"] &&
                                     input["approved_same_run_fallback"] != true
    "MODEL_ROUTE_RECEIPT_PASS"

  when "spawn_receipt"
    return "SPAWN_RECEIPT_MISSING" if input["spawned_work"] == true &&
                                      (blank?(input["spawn_receipt"]) || input["spawn_receipt"] == "not_applicable")
    "SPAWN_RECEIPT_PASS"

  when "no_fake_pass"
    return "NO_FAKE_PASS_BLOCKED" if input["implementation_claim"] == "PASS" &&
                                     %w[NOT_PROVEN PARTIAL BLOCKED UNRESOLVED].include?(input["qa_state"])
    "NO_FAKE_PASS_PASS"

  when "task_service_physical_write"
    if input["done_requested"] == true &&
       %w[NOOP non_actionable PHYSICAL_TASK_WRITE_MISSING].include?(input["task_service_status"]) &&
       blank?(input["issue_id"])
      return "TASK_SERVICE_PHYSICAL_WRITE_MISSING"
    end
    "TASK_SERVICE_PHYSICAL_WRITE_PASS"

  when "final_output_compressor"
    return "FINAL_OUTPUT_POLICY_FAIL" unless input["final_output"].to_s.match?(FINAL_PATTERN)
    return "FINAL_OUTPUT_POLICY_FAIL" if input["final_output"].to_s.lines.length != 3
    "FINAL_OUTPUT_COMPRESSOR_PASS"

  when "product_api_first"
    return "API_OR_DOCS_MECHANISM_NOT_FOUND" if input["product_task"] == true &&
                                                input["direct_db_before_api_docs"] == true
    "PRODUCT_API_FIRST_PASS"

  when "t0_boundary"
    return "BLOCKED_T0_DIRECT_MUTATION" if input["role"] == "T0_CONTROL" &&
                                           input["implementation_mutation"] == true
    "T0_CONTROL_PLANE_ONLY_PASS"

  when "done_gate"
    required = %w[
      implementation_evidence validation_evidence receipt task_readback
      no_blocker no_forbidden_zone register_index pr_queue
    ]
    return "DONE_WITH_EVIDENCE" if required.all? { |field| input[field] == "PASS" }
    return input["typed_blocker"] if %w[
      TASK_SERVICE_PHYSICAL_WRITE_MISSING OWNER_ONLY_IRREVERSIBLE_GATE
      INSTRUCTION_SOURCE_DRIFT FORBIDDEN_SCOPE_TOUCH ROLLBACK_NOT_PROVEN
      LIVE_PATH_NOT_PROVEN MODEL_ROUTE_MISMATCH SPAWN_RECEIPT_MISSING
      CONTEXT_BLOAT_DEFECT DEADLOCK_RETRY_LIMIT_REACHED USER_CHAT_STOP_DEFECT
      API_OR_DOCS_MECHANISM_NOT_FOUND
    ].include?(input["typed_blocker"])
    "DONE_GATE_INCOMPLETE"

  else
    "NO_CHAT_DEADLOCK_CONTOUR_GATE_MISSING"
  end
end

failures = cases.filter_map do |item|
  actual = route(item.fetch("input"))
  expected = item.fetch("expected")
  next if actual == expected

  { "id" => item.fetch("id"), "expected" => expected, "actual" => actual }
end

if failures.empty?
  puts JSON.pretty_generate({ "status" => "PASS", "cases" => cases.length, "validator" => File.basename(__FILE__) })
else
  warn JSON.pretty_generate({ "status" => "FAIL", "failures" => failures })
  exit 1
end
