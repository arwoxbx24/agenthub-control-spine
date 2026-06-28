---
artifact_id: agenthub-runtime-tool-installation-policy
artifact_type: active_policy
source_task: AH-765
run_id: RUN-AGENTHUB-AUTHORITY-LIFECYCLE-EXPANSION-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Runtime Tool Installation Policy

## Required Routes

The following routes are durable AgentHub runtime capabilities:

- `agent_hub_authority_envelope_create`
- `agent_hub_authority_envelope_readback`
- `agent_hub_worker_route_install`
- `agent_hub_worker_route_probe`
- `agent_hub_validator_execute`
- `agent_hub_packfix_upsert`
- `agent_hub_packfix_resolve`
- `agent_hub_done_gate_check`
- `agent_hub_model_truth_probe`
- `agent_hub_microservice_probe`
- `agent_hub_browser_outcome_probe`
- `youtrack_stage_move_with_readback`
- `control_spine_register_update`
- `receipt_write_and_validate`

## Route Manifest

Every installed route must have a manifest with route id, lane, task id, run id,
allowed operations, forbidden operations, canary command or proof, validation
commands, rollback note, redaction gate, and evidence sink.

## Safety

Runtime tool installation does not grant blanket shell, DB, Docker, proxy,
firewall, DNS, SSL, secret, payment, legal, or destructive authority. Those
surfaces remain lane-gated.

## Closure

`RUNTIME_TOOL_INSTALLATION_REQUIRED` is not terminal. The same RUN must install
or register the route, prove it, write a receipt, and re-run the Done gate.
