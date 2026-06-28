#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

SELF_HEALING_MAP = {
  "TASK_CARD_PAYLOAD_REPAIR_REQUIRED" => "Create or update minimal task card and route metadata",
  "TASK_ID_SELF_HEALING_REQUIRED" => "Attach existing task id or create minimal safe card",
  "RUN_STATE_SELF_HEALING_REQUIRED" => "Attach RUN_ID from active contour",
  "MODEL_FALLBACK_RECEIPT_REPAIR_REQUIRED" => "Write model fallback receipt artifact",
  "SHARE_FALLBACK_TO_REPO_ARTIFACT_REQUIRED" => "Store outcome in repo artifact register",
  "STATUS_CONTEXT_MAPPING_REPAIR_REQUIRED" => "Patch workflow/status map in contour",
  "CONTROL_SPINE_AUTHORSHIP_CLASSIFICATION_REPAIR_REQUIRED" => "Classify action as control-spine artifact authorship",
  "WORD_FILTER_PAYLOAD_REWRITE_REQUIRED" => "Apply safe-vocabulary payload rewrite",
  "PROGRESS_OUTPUT_SUPPRESSED_CONTINUE" => "Suppress duplicate progress and continue"
}.freeze

def self_healing_required?(gate)
  SELF_HEALING_MAP.key?(gate)
end

def required_fields
  %w[gate]
end

def missing?(payload)
  payload ||= {}
  required_fields.select { |field| payload[field].nil? || payload[field].to_s.empty? }
end

def decision(payload = {})
  payload ||= {}
  gate = payload["gate"] || payload["blocker"] || ""
  if self_healing_required?(gate)
    {
      "allowed" => true,
      "allow" => true,
      "repair" => {
        "gate" => gate,
        "repair_action" => SELF_HEALING_MAP[gate],
        "lane" => payload["lane"] || 3,
        "repeat_limit" => 1
      },
      "blocker" => nil,
      "retry_limit_reached" => false,
      "detail" => "Routine blocker mapped to scoped self-healing action."
    }
  else
    { "allowed" => false, "allow" => false, "blocker" => gate, "detail" => "Not a self-healing gate." }
  end
end

if $PROGRAM_NAME == __FILE__
  payload = JSON.parse(STDIN.read) rescue {}
  output = decision(payload)
  puts JSON.pretty_generate(output)
  exit(output["allow"] ? 0 : 1)
end
