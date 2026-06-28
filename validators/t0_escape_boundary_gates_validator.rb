#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require_relative "agenthub_action_policy_validator"

# Lane-aware boundary policy for T0/T1/T2 route execution.
#
# This validator now classifies routine gates into repair events when they are
# in-scope for the active contour and only returns terminal blocks when
# destructive or secret-bearing operations require explicit proof.
def required_fields
  AgentHubActionPolicyValidator.required_fields
end

def missing?(payload)
  AgentHubActionPolicyValidator.missing?(payload)
end

def decision(payload = {})
  result = AgentHubActionPolicyValidator.decision(payload)

  # Hardening: force same_gate retry semantics so a repeated gate stops as root
  # blocker while first failure emits self-healing event.
  failures = payload.to_h["same_gate_failures"].to_i
  gate = payload.to_h["gate"].to_s
  if failures > 1 && AgentHubActionPolicyValidator::ROUTINE_TO_SELF_HEALING.key?(gate)
    result["allowed"] = false
    result["allow"] = false
    result["blocker"] = "TASK_CARD_PAYLOAD_REPAIR_REQUIRED"
    result["gate"] = "TASK_CARD_PAYLOAD_REPAIR_REQUIRED"
    result["detail"] = "Routine gate repeated twice; root-cause repair task required."
  end

  result
end

if $PROGRAM_NAME == __FILE__
  input = JSON.parse(STDIN.read) rescue {}
  output = decision(input)
  puts JSON.pretty_generate(output)
  exit(output["allow"] ? 0 : 1)
end
