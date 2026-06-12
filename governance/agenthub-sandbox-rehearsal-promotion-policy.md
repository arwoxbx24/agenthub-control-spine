---
artifact_id: agenthub-sandbox-rehearsal-promotion-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker / Sandbox Worker
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Sandbox Rehearsal Promotion Policy

Risky code, config, Docker, DB-copy, API, browser, proxy, network, or microservice work must rehearse outside live production before promotion.

## Descriptor required

Every sandbox must record `sandbox_id`, `source_task`, `run_id`, `project_root`, `component`, `stack_type`, `input_snapshot`, `config_source`, `secret_handling`, `data_strategy`, `network_strategy`, allowed and forbidden commands, success metrics, failure metrics, rollback plan, and promotion gate.

## Promotion gate

Promotion requires sandbox PASS, minimal diff plan, rollback proof, live authority envelope, final validation plan, and owner-only gate only when the action is irreversible.

Sandbox proof alone is never production Done.
