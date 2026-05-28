#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

path = ARGV.fetch(0)
doc = JSON.parse(File.read(path))
cases = doc.fetch("cases")

T0_RUNTIME_ROUTES = %w[
  shell_direct language_runtime docker_compose kubernetes_systemctl_service
  cloud_cli curl_http_api ssh_terminal db_client proxy_npm_dns_ssl git_gh_write
].freeze

def blank?(value)
  value.nil? || (value.respond_to?(:empty?) && value.empty?)
end

def decision(input)
  route_id = input.fetch("route_id", "")
  registered = input.fetch("registered_routes", [])
  return "DENY_UNREGISTERED_ROUTE" unless registered.include?(route_id)
  return "DENY_RUN_ID_MISSING" if blank?(input["run_id"])
  return "DENY_TASK_ID_MISSING" if blank?(input["task_id"])
  return "DENY_NO_REPO_RECEIPT_TARGET" if blank?(input["repo_receipt_target"])
  return "DENY_SESSION_UNBOUND" if route_id == "ssh_terminal" && !input.fetch("session_bound", true)
  return "DENY_SECRET_LEAK" if input.fetch("secret_in_output", false)
  return "STOP_RETRY_AND_SELF_REPAIR_POLICY" if input.fetch("same_gate_failures", 0).to_i >= 2

  role = input.fetch("actor_role")
  operation = input.fetch("operation", "")
  target_surface = input.fetch("target_surface", "")
  allowed = input.fetch("allowed_surfaces", [])
  forbidden = input.fetch("forbidden_surfaces", [])

  return "DENY_T0_DIRECT_ACTION" if role == "T0_CONTROL" && T0_RUNTIME_ROUTES.include?(route_id)
  return "DENY_ARCHITECT_RUNTIME_ACTION" if role == "T1_ARCHITECT" && operation == "runtime_mutate"
  return "DENY_SURFACE_FORBIDDEN" if forbidden.include?(target_surface)
  return "DENY_SURFACE_NOT_ALLOWED" unless allowed.include?(target_surface)

  if input.fetch("code_like", false)
    return "DENY_MODEL_ROUTER_MISSING" unless input.fetch("codex_route_attempted", false)
    if input.fetch("fallback_model_used", false)
      return "DENY_MODEL_FALLBACK_UNPROVEN" unless input.fetch("same_run_fallback", false) && !blank?(input["primary_unavailable_evidence_ref"])
    end
  end

  return "ALLOW_T0_CONTROL_ROUTE" if role == "T0_CONTROL" && route_id == "mcp_tool"
  return "ALLOW_REGISTRAR_ROUTE" if role == "REGISTRAR"
  return "ALLOW_VERIFIER_READONLY" if role == "VERIFIER"
  return "ALLOW_SCOPED_ROUTE_WITH_RECEIPT" if role.start_with?("T2_")

  "DENY_UNSUPPORTED_ROLE"
end

failures = cases.filter_map do |item|
  actual = decision(item.fetch("input"))
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

