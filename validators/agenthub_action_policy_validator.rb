#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

module AgentHubActionPolicyValidator
  ROUTINE_TO_SELF_HEALING = {
    "PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID" => "TASK_ID_SELF_HEALING_REQUIRED",
    "DISPATCH_TASK_GATE_MISSING" => "RUN_STATE_SELF_HEALING_REQUIRED",
    "CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED" => "SCOPED_T2_REPAIR_ALLOWED_WHEN_BOUND",
    "T0_DIRECT_AUTHORSHIP_DEFECT" => "CONTROL_SPINE_AUTHORSHIP_CLASSIFICATION_REPAIR_REQUIRED",
    "MODEL_FALLBACK_RECEIPT_MISSING" => "MODEL_FALLBACK_RECEIPT_REPAIR_REQUIRED",
    "DUPLICATE_PROGRESS_OUTPUT_BLOCKED" => "PROGRESS_OUTPUT_SUPPRESSED_CONTINUE",
    "PHYSICAL_TASK_WRITE_MISSING" => "TASK_CARD_PAYLOAD_REPAIR_REQUIRED",
    "TASK_PAYLOAD_WORD_FILTER_FAILURE" => "WORD_FILTER_PAYLOAD_REWRITE_REQUIRED",
    "SHARE_PUBLICATION_FAILURE" => "SHARE_FALLBACK_TO_REPO_ARTIFACT_REQUIRED",
    "STATUS_CONTEXT_MAPPING_MISMATCH" => "STATUS_CONTEXT_MAPPING_REPAIR_REQUIRED"
  }.freeze

  LANE_PROFILE = {
    "0" => :chat_report_compression,
    "1" => :control_spine_artifacts,
    "2" => :repository_lifecycle,
    "3" => :routine_self_healing,
    "4" => :runtime_read_only_diagnostic,
    "5" => :bounded_runtime_repair,
    "6" => :destructive_with_proof
  }.freeze

  CONTROL_SPINE_PATH_PREFIXES = [
    "governance/",
    "context/",
    "artifacts/",
    "schemas/",
    "INDEX.md",
    "ARTIFACT_REGISTER.md",
    "PR_QUEUE_REGISTER.md",
    "AGENTS.md",
    "context/agenthub-current-context-pack.md",
    "AGENTHUB-PROJECT-MASTER-ARTIFACT.txt"
  ].freeze

  CONTROL_SPINE_ACTIONS = %w[
    ROUTE_WRITES
    CONTROL_SPINE_ARTIFACT_AUTHORSHIP_ALLOWED
    WRITE_REPORT
    WRITE_RECEIPT
    UPDATE_REGISTER
    UPDATE_INDEX
    UPDATE_PR_QUEUE
    ADD_REGISTER_ENTRY
    UPDATE_ROUTER_POLICY
  ].freeze

  READER_KEYS = %w[task_id run_id issue_id gate blocker action role scope lane intent evidence evidence_payload]
  TERMINAL_BLOCKERS = [
    "OWNER_APPROVAL_REQUIRED_FOR_DESTRUCTIVE_DELETE",
    "BACKUP_OR_REPLACEMENT_PROOF_REQUIRED",
    "UNKNOWN_PRODUCTION_DATA_RISK",
    "SECRET_EXPOSURE_RISK",
    "BROAD_INFRASTRUCTURE_MUTATION_NOT_AUTHORIZED",
    "NO_SCOPED_T2_ROUTE_FOR_RUNTIME_REPAIR",
    "REPO_LIFECYCLE_INVENTORY_REQUIRED",
    "SCOPE_LANE_CONFLICT",
    "INSTRUCTION_SOURCE_DRIFT",
    "TASK_PAYLOAD_MISSING_REQUIRED_FIELDS"
  ].freeze

  REQUIRED_FIELDS = %w[role action lane].freeze

  def self.required_fields
    REQUIRED_FIELDS
  end

  def self.missing?(payload)
    payload ||= {}
    required_fields.select { |field| payload[field].nil? || payload[field].to_s.strip.empty? }
  end

  def self.decision(payload = {})
    payload ||= {}
    normalized = normalize(payload)

    missing = missing?(normalized)
    unless missing.empty?
      return out(
        allowed: false,
        lane: normalized[:lane],
        gate: "TASK_PAYLOAD_MISSING_REQUIRED_FIELDS",
        blocker: "TASK_PAYLOAD_MISSING_REQUIRED_FIELDS",
        detail: "Missing payload fields: #{missing.join(", ")}"
      )
    end

    lane = normalized[:lane]
    gate = normalized[:gate]
    action = normalized[:action]
    scope = normalized[:scope]
    artifact_path = normalized[:artifact_path]
    same_gate_failures = normalized[:same_gate_failures].to_i

    repair = ROUTINE_TO_SELF_HEALING[gate]
    if repair
      return self_healing_gate(lane, repair, same_gate_failures)
    end

    if routine_missing_ids?(normalized)
      return self_healing_gate(lane, "TASK_ID_SELF_HEALING_REQUIRED", same_gate_failures, allow: true)
    end

    return out(
      allowed: false,
      lane: lane,
      gate: "TASK_CARD_PAYLOAD_REPAIR_REQUIRED",
      blocker: "TASK_CARD_PAYLOAD_REPAIR_REQUIRED",
      detail: "Missing task or run identity while routing requires active contour binding.",
      retry_limit_reached: same_gate_failures >= 1
    ) if normalized[:task_id].to_s.empty? || normalized[:run_id].to_s.empty?

    return control_spine_authority(normalized) if lane == 1
    return runtime_read_only_guard(normalized) if lane == 4
    return bounded_runtime_guard(normalized) if lane == 5
    return destructive_guard(normalized) if lane == 6

    out(
      allowed: true,
      lane: lane,
      gate: "PASS",
      blocker: nil,
      detail: "Scoped self-healing policy allows this action in lane #{lane}."
    )
  end

  def self.normalize(payload)
    action = (payload["action"] || payload["intent"] || payload["operation"] || "").to_s
    {
      role: (payload["role"] || payload["agent_role"] || "").to_s.upcase,
      lane: (payload["lane"] || payload["lane_id"] || payload["contour_lane"] || infer_lane(payload)).to_s,
      action: action,
      scope: (payload["scope"] || payload["contour"] || "").to_s,
      gate: (payload["gate"] || payload["blocker"] || payload["error_code"] || "").to_s,
      artifact_path: (payload["artifact_path"] || payload["file_path"] || payload["path"] || "").to_s,
      task_id: (payload["task_id"] || payload["issue_id"] || "").to_s,
      run_id: (payload["run_id"] || "").to_s,
      same_gate_failures: payload["same_gate_failures"].to_i,
      evidence: payload["evidence"] || payload["proof"] || {}
    }
  end

  def self.infer_lane(payload)
    action = (payload["action"] || payload["intent"] || "").to_s
    artifact_path = (payload["artifact_path"] || payload["path"] || "").to_s
    scope = (payload["scope"] || payload["contour"] || "").to_s
    return "1" if control_spine_candidate?(artifact_path, scope, action)
    return "4" if action.match?(/\b(status|health|logs|diag|diagnostic|inspect)\b/i)
    return "6" if action.match?(/\b(delete|destroy|prune|drop|remove|migration|recreate)\b/i)
    "3"
  end

  def self.control_spine_candidate?(path, scope, action)
    CONTROL_SPINE_PATH_PREFIXES.any? { |prefix| path.start_with?(prefix) } ||
      scope.to_s.downcase.include?("control-spine") ||
      action.to_s.downcase.include?("register") ||
      action.to_s.downcase.include?("artifact") ||
      action.to_s.downcase.include?("receipt") ||
      action.to_s.downcase.include?("schema")
  end

  def self.routine_missing_ids?(payload)
    payload[:action].to_s.match?(/\b(route|dispatch|repair|restore|dispatch)\b/i) &&
      payload[:run_id].to_s.empty?
  end

  def self.self_healing_gate(lane, repair_gate, same_gate_failures, allow: nil)
    can_retry = (same_gate_failures <= 1)
    out(
      allowed: allow.nil? ? can_retry : allow,
      lane: lane,
      gate: can_retry ? repair_gate : "TASK_CARD_PAYLOAD_REPAIR_REQUIRED",
      blocker: can_retry ? nil : "TASK_CARD_PAYLOAD_REPAIR_REQUIRED",
      detail: can_retry ? "Converted routine blocker into self-healing event." : "Routine blocker repeated; require repair task and continue.",
      repair: { action: repair_gate, one_retry: can_retry, retry_count: same_gate_failures },
      retry_limit_reached: !can_retry
    )
  end

  def self.control_spine_authority(payload)
    role = payload[:role].to_s
    action = payload[:action].to_s
    artifact = payload[:artifact_path].to_s
    control_spine_ok = lane_profile_control_spine?(payload)
    if !control_spine_ok
      return out(
        allowed: false,
        lane: payload[:lane],
        gate: "T0_DIRECT_AUTHORSHIP_DEFECT",
        blocker: "T0_DIRECT_AUTHORSHIP_DEFECT",
        detail: "Control-spine artifact write attempted outside allowed control-spine contract.",
        retry_limit_reached: false
      )
    end

    if role =~ /\AT0/ && !(CONTROL_SPINE_ACTIONS.any? { |a| action.include?(a) } || control_spine_path?(artifact))
      return out(
        allowed: false,
        lane: payload[:lane],
        gate: "CONTROL_SPINE_ARTIFACT_AUTHORSHIP_ALLOWED",
        blocker: "CONTROL_SPINE_ARTIFACT_AUTHORSHIP_ALLOWED",
        detail: "T0/T1 action in lane 1 must target control-spine policy artifacts.",
        retry_limit_reached: false
      )
    end

    out(
      allowed: true,
      lane: payload[:lane],
      gate: "CONTROL_SPINE_AUTHORSHIP_ALLOWED",
      blocker: nil,
      detail: "T0/T1 control-spine authorship allowed under lane 1.",
      repair: { action: "CONTROL_SPINE_ARTIFACT_AUTHORSHIP_ALLOWED" }
    )
  end

  def self.lane_profile_control_spine?(payload)
    action = payload[:action].to_s
    path = payload[:artifact_path].to_s
    return true if control_spine_path?(path)
    CONTROL_SPINE_ACTIONS.any? { |entry| action.include?(entry) }
  end

  def self.control_spine_path?(path)
    CONTROL_SPINE_PATH_PREFIXES.any? { |prefix| path.start_with?(prefix) }
  end

  def self.runtime_read_only_guard(payload)
    if payload[:action] =~ /(write|patch|update|delete|remove|restart|rollback|repair|deploy|edit)/
      return out(
        allowed: false,
        lane: payload[:lane],
        gate: "READ_ONLY_DIAGNOSTIC_NOT_BLOCKED_BY_RUNTIME_MUTATION_RULE",
        blocker: "READ_ONLY_DIAGNOSTIC_NOT_BLOCKED_BY_RUNTIME_MUTATION_RULE",
        detail: "Lane 4 allows read-only diagnostics only.",
        retry_limit_reached: true
      )
    end

    out(
      allowed: true,
      lane: payload[:lane],
      gate: "PASS",
      blocker: nil,
      detail: "Lane 4 read-only diagnostics allowed."
    )
  end

  def self.bounded_runtime_guard(payload)
    scope = payload[:scope].to_s
    action = payload[:action].to_s
    return out(
      allowed: false,
      lane: payload[:lane],
      gate: "NO_SCOPED_T2_ROUTE_FOR_RUNTIME_REPAIR",
      blocker: "NO_SCOPED_T2_ROUTE_FOR_RUNTIME_REPAIR",
      detail: "Lane 5 requires a scoped T2 route authorization.",
      retry_limit_reached: false
    ) unless scope.include?("scoped") || scope.include?("repair") || payload[:evidence].to_h["t2_worker_route"]

    out(
      allowed: true,
      lane: payload[:lane],
      gate: "SCOPED_T2_RUNTIME_REPAIR_ALLOWED",
      blocker: nil,
      detail: "Lane 5 runtime repair is scoped and allowed."
    )
  end

  def self.destructive_guard(payload)
    proof = proof_for_payload(payload)
    env = proof["environment_class"].to_s.downcase
    object = payload[:artifact_path].to_s
    return out(
      allowed: false,
      lane: payload[:lane],
      gate: "UNKNOWN_PRODUCTION_DATA_RISK",
      blocker: "UNKNOWN_PRODUCTION_DATA_RISK",
      detail: "Cannot validate environment class for destructive action.",
      retry_limit_reached: false
    ) if env.empty?

    return out(
      allowed: false,
      lane: payload[:lane],
      gate: "SECRET_EXPOSURE_RISK",
      blocker: "SECRET_EXPOSURE_RISK",
      detail: "Destructive proof carries secret-bearing payload."
    ) if proof["secret_risk"] == true

    return out(
      allowed: true,
      lane: payload[:lane],
      gate: "PASS",
      blocker: nil,
      detail: "Destructive action accepted with Lane 6 proof."
    ) if proof["lane6"]["owner_approved"] == true ||
      proof["lane6"]["replacement_proven"] == true ||
      proof["lane6"]["backup_verified"] == true ||
      (env != "production" && proof["lane6"]["test_approved"] == true)

    blocker = if object.include?("database") && env == "production"
      "BACKUP_OR_REPLACEMENT_PROOF_REQUIRED"
    elsif proof["lane6"].to_h["broad_scope"] == true
      "BROAD_INFRASTRUCTURE_MUTATION_NOT_AUTHORIZED"
    else
      "OWNER_APPROVAL_REQUIRED_FOR_DESTRUCTIVE_DELETE"
    end

    out(
      allowed: false,
      lane: payload[:lane],
      gate: blocker,
      blocker: blocker,
      detail: "Lane 6 destructive guard failed: missing required proof schema."
    )
  end

  def self.proof_for_payload(payload)
    data = payload[:evidence].to_h
    data["lane6"] = data["lane6"] || {}
    data
  end

  def self.out(allowed:, lane:, gate:, blocker:, detail:, repair: nil, retry_limit_reached: false)
    {
      "allowed" => allowed,
      "allow" => allowed,
      "lane" => lane,
      "lane_name" => LANE_PROFILE[lane] || LANE_PROFILE["3"],
      "gate" => gate,
      "blocker" => blocker,
      "detail" => detail,
      "repair" => repair,
      "retry_limit_reached" => retry_limit_reached,
      "required_validation" => TERMINAL_BLOCKERS.include?(blocker.to_s) ? "terminal" : "self-healing"
    }
  end

  private_class_method :destructive_guard
end

def required_fields
  AgentHubActionPolicyValidator.required_fields
end

def missing?(payload)
  AgentHubActionPolicyValidator.missing?(payload)
end

def decision(payload = {})
  AgentHubActionPolicyValidator.decision(payload)
end

if $PROGRAM_NAME == __FILE__
  input = JSON.parse(STDIN.read) rescue {}
  result = AgentHubActionPolicyValidator.decision(input)
  puts JSON.pretty_generate(result)
  exit(result["allow"] ? 0 : 1)
end
