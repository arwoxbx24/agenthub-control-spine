#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

PACKAGED = %w[ready_made_product vendor_app dockerized_product cms saas panel mcp_server task_service].freeze
OWNED = "owned_application_code"
CUSTOM_API = "custom_service_api"
INFRA = "infrastructure"
UNKNOWN = "unknown_product"

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def missing?(input, fields)
  fields.any? { |field| blank?(input[field]) }
end

def docs_required?(input)
  return true if PACKAGED.include?(input["surface_class"])
  return true if [CUSTOM_API, INFRA, UNKNOWN].include?(input["surface_class"])
  return true if input["security_or_auth"] == true || input["db_or_runtime"] == true
  return true if input["framework_uncertain"] == true || input["prior_failure"] == true
  return true if input.fetch("confidence", 1.0).to_f < 0.85
  false
end

def official_route?(input)
  %w[api admin_panel cli sdk mcp documented_config migration supported_deploy].include?(input["supported_mechanism"])
end

def route(input)
  gate = input.fetch("gate")

  case gate
  when "surface_classification"
    return "UNVERIFIED_PRODUCT_SURFACE" if input["surface_class"] == UNKNOWN && input["product_identified"] != true
    return "DOCS_LOOKUP_REQUIRED" if docs_required?(input) && input["documentation_lookup"] != "PASS"
    return "OWNED_CODE_LOCAL_FIX_ALLOWED" if input["surface_class"] == OWNED &&
                                             input["trivial_local_error"] == true &&
                                             input["compiler_or_test_evidence"] == "PASS"
    "SURFACE_CLASSIFICATION_PASS"

  when "api_route_sheet"
    required = %w[product_name official_docs_ref auth_method validation_route rollback_route forbidden_direct_internals]
    return "API_ROUTE_REQUIRED" if PACKAGED.include?(input["surface_class"]) && !official_route?(input)
    return "API_ROUTE_SHEET_INCOMPLETE" if missing?(input, required)
    return "API_ROUTE_SHEET_PASS"

  when "mutation_firewall"
    return "BLOCKED_T0_DIRECT_AUTHORSHIP" if input["role"] == "T0_CONTROL" && input["mutation_requested"] == true
    return "BLOCKED_PRODUCT_DB_MUTATION" if input["direct_db_write"] == true && input["db_mutation_authority"] != true
    return "BLOCKED_PRODUCT_INTERNAL_DOCKER_SURGERY" if input["container_internal_patch"] == true &&
                                                        input["docker_internal_emergency_authority"] != true
    return "FORBIDDEN_SCOPE_BLOCKER" if input["proxy_firewall_dns_mutation"] == true && input["scoped_live_authority"] != true
    return "SECRET_OR_RAW_LINK_RISK" if input["secret_or_env_dump"] == true
    return "DOMAIN_HARDCODE_RISK" if input["hardcoded_domain_or_uuid"] == true
    return "DOCS_UNAVAILABLE_MUTATION_FAIL" if input["mutation_requested"] == true &&
                                               docs_required?(input) &&
                                               input["documentation_lookup"] != "PASS"
    "MUTATION_FIREWALL_PASS"

  when "truth_ledger"
    return "FAKE_PASS_BLOCKED" if input["claim_status"] != "EVIDENCED" && input["claims_done"] == true
    return "MODEL_ROUTE_MISMATCH" if input["requested_model"] && input["actual_model"] &&
                                     input["requested_model"] != input["actual_model"] &&
                                     input["fallback_approved"] != true
    return "MCP_PROOF_REQUIRED" if input["mcp_claim"] == true && input["mcp_tool_receipt"] != "PASS"
    return "NO_USER_OUTCOME_PROOF" if input["product_done_claim"] == true && input["user_outcome_proof"] != "PASS"
    "TRUTH_LEDGER_PASS"

  when "artifact_lifecycle"
    return "ARTIFACT_LIFECYCLE_DRIFT" if input["old_report_lifecycle"].to_s.match?(/audit_only|consumed|superseded|quarantine/) &&
                                         input["used_as_instruction"] == true
    return "PR_QUEUE_FAIL" if input["pr_created"] == true && input["pr_queue_owner_state"] != "PASS"
    return "REGISTRAR_FAIL" if input["artifact_added"] == true && input["index_and_register"] != "PASS"
    "ARTIFACT_LIFECYCLE_PASS"

  when "user_front"
    return "USER_ACTION_LEAK" if input["mid_cycle_user_chat"] == true && input["owner_only_gate"] != true
    return "USER_OUTPUT_POLICY_FAIL" if input["final_contains_technical_dump"] == true
    "USER_FRONT_PASS"

  when "retry_loop"
    return "REPEATED_GATE_LOOP" if input.fetch("same_gate_failures", 0).to_i >= 2 &&
                                   input["architecture_repair_or_typed_blocker"] != true
    "RETRY_LOOP_PASS"

  when "emergency_exception"
    required = %w[docs_checked api_absent adr rollback explicit_authority user_outcome_validation]
    return "EMERGENCY_SCOPE_BLOCKED" unless required.all? { |field| input[field] == "PASS" }
    "EMERGENCY_EXCEPTION_PASS"

  when "done_gate"
    required = %w[audit adr policy schemas validator fixtures templates registers pr_queue receipt security_scan]
    return "DONE_WITH_EVIDENCE" if required.all? { |field| input[field] == "PASS" } &&
                                   input["active_blocker"] == "none"
    return input["active_blocker"] if %w[
      DOCS_UNAVAILABLE_BLOCKER
      API_ROUTE_UNAVAILABLE_BLOCKER
      MODEL_ROUTE_MISMATCH_BLOCKER
      OWNER_ONLY_IRREVERSIBLE_GATE
      FORBIDDEN_SCOPE_BLOCKER
      SAFETY_QUARANTINE
    ].include?(input["active_blocker"])
    "DONE_GATE_EVIDENCE_MISSING"

  else
    "API_DOCS_GATE_MISSING"
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
