#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

FORBIDDEN_ROOTS = [
  "/root/gemini-space",
  "/root/codex-space",
  "/var/lib/docker",
  "/var/lib/docker/overlay2"
].freeze

FORBIDDEN_COMMANDS = %w[
  docker_volume_prune
  docker_system_prune
  docker_compose_down_v
  db_write
  proxy_firewall_dns_mutation
  secret_dump
].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def missing?(input, fields)
  fields.any? { |field| blank?(input[field]) }
end

def forbidden_path?(path)
  return true if path.to_s.start_with?("/tmp") && path.to_s.include?("production")

  FORBIDDEN_ROOTS.any? { |root| path.to_s == root || path.to_s.start_with?("#{root}/") }
end

def under_any?(path, roots)
  Array(roots).any? { |root| path.to_s == root || path.to_s.start_with?("#{root}/") }
end

def docs_required?(input)
  input["existing_product"] == true ||
    input["framework_behavior"] == true ||
    input["docker_or_volume_behavior"] == true ||
    input["security_or_auth"] == true ||
    input["unknown_product"] == true
end

def blind?(input)
  required = %w[
    current_state_proof source_of_truth official_mechanism_decision
    active_target_path_proof scope_manifest backup_or_rollback
    validation_plan task_evidence_target no_secret_policy forbidden_zone_proof
  ]
  missing?(input, required)
end

def route(input)
  case input.fetch("gate")
  when "scope_manifest"
    required = %w[
      RUN_ID task_id task_class role worker_id product_or_service objective
      READ_ALLOWED_ROOTS WRITE_ALLOWED_ROOTS EXEC_ALLOWED_COMMAND_CLASSES
      FORBIDDEN_ROOTS FORBIDDEN_COMMAND_CLASSES ACTIVE_RUNTIME_PATH_PROOF
      OFFICIAL_MECHANISM_DECISION BACKUP_PLAN ROLLBACK_PLAN VALIDATION_PLAN
      DYNAMIC_SCOPE_EXPANSION_POLICY NO_USER_CHAT_POLICY
    ]
    return "SCOPE_MANIFEST_MISSING" if missing?(input, required)
    return "WRITE_ALLOWLIST_TOO_BROAD" if Array(input["WRITE_ALLOWED_ROOTS"]).any? { |root| ["/", "/root", "/opt", "/var"].include?(root) }
    "SCOPE_MANIFEST_PASS"

  when "path_write"
    target = input["target_path"]
    return "NON_LIVE_PATH_EVIDENCE" if target.to_s.start_with?("/tmp") && input["claims_production_done"] == true
    return "FORBIDDEN_SCOPE_BLOCKER" if forbidden_path?(target)
    return "OUT_OF_SCOPE_MUTATION" unless under_any?(target, input["WRITE_ALLOWED_ROOTS"])
    "PATH_WRITE_PASS"

  when "scope_expansion"
    return "SCOPE_EXPANSION_REQUIRED" if input["new_path_discovered"] == true &&
                                         input["write_attempted"] == true &&
                                         input["t1_scope_approved"] != true
    return "SCOPE_EXPANSION_PASS" if input["new_path_discovered"] != true ||
                                     (input["scope_expansion_request"] == "PASS" &&
                                      input["t1_scope_approved"] == true &&
                                      input["manifest_updated"] == true)
    "SCOPE_EXPANSION_INCOMPLETE"

  when "backup"
    return "NO_ROLLBACK_POINT" if input["mutation_requested"] == true &&
                                  (input["backup_hash"].to_s.empty? || input["rollback_plan"].to_s.empty?)
    return "BACKUP_SIZE_UNKNOWN" if input["broad_directory_copy"] == true && input["size_proof"] != "PASS"
    return "FORBIDDEN_DATA_BACKUP" if input["data_volume_or_db_backup"] == true && input["explicit_backup_gate"] != true
    return "BACKUP_TOO_LARGE_FOR_SAFE_RUN" if input.fetch("backup_size_mb", 0).to_i > 100 &&
                                              input["t1_backup_approval"] != true
    "BACKUP_GATE_PASS"

  when "docs_api"
    return "DOCUMENTATION_REQUIRED_BEFORE_MUTATION" if docs_required?(input) &&
                                                       input["docs_decision_record"] != "PASS"
    return "API_FIRST_VIOLATION" if input["api_or_ui_available"] == true &&
                                    input["direct_db_patch"] == true
    return "DOCS_GATE_PASS" if input["trivial_owned_syntax_fix"] == true &&
                               input["scope_backup_test"] == "PASS"
    "DOCS_GATE_PASS"

  when "docker_db"
    return "BLOCKED_T0_DIRECT_MUTATION" if input["role"] == "T0_CONTROL" &&
                                           input["docker_or_db_mutation"] == true
    return "FORBIDDEN_DOCKER_DATA_DESTRUCTION" if FORBIDDEN_COMMANDS.include?(input["command_class"])
    "DOCKER_DB_GATE_PASS"

  when "blind_mutation"
    return "BLIND_MUTATION_BLOCKED" if input["mutation_requested"] == true && blind?(input)
    "NO_BLIND_MUTATION_PASS"

  when "chat_loop"
    return "MID_CYCLE_CHAT_STOP" if input["state"] == "ACTIVE_RUN" &&
                                    input["progress_chat_to_user"] == true
    return "DEADLOCK_LOOP_DETECTED" if input.fetch("same_gate_failures", 0).to_i >= 2 &&
                                       input["architecture_repair_microtask"] != true
    return "TOKEN_BLOAT_RETRY" if input["context_window_failure"] == true &&
                                  input["same_huge_prompt_retry"] == true
    "CHAT_LOOP_PASS"

  when "done_gate"
    return "USER_OUTCOME_PROOF_REQUIRED" if input["done_claim"] == true &&
                                            input["green_curl_only"] == true
    required = %w[implementation_evidence validation_evidence receipt task_readback no_blocker]
    return "DONE_GATE_INCOMPLETE" if input["done_claim"] == true && required.any? { |field| input[field] != "PASS" }
    return "DONE_WITH_EVIDENCE" if input["done_claim"] == true && required.all? { |field| input[field] == "PASS" }
    "DONE_GATE_PASS"

  else
    "BOUNDARY_BACKUP_DOCS_GATE_MISSING"
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
