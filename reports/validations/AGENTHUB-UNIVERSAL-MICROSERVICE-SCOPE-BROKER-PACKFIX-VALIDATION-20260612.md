---
artifact_id: agenthub-universal-microservice-scope-broker-packfix-validation-20260612
artifact_type: validation_report
owner_role: Registrar / Verifier
source_task: AH-748
run_id: RUN-AGENTHUB-UNIVERSAL-MICROSERVICE-SCOPE-BROKER-20260612-PACKFIX-VALIDATION
created_at: 2026-06-12
lifecycle_status: validation_pass
safe_to_replay: false
---

# AH-748 PackFix Validation Route Repair

## Scope

Control-spine repository governance package only. No VPN, runtime service, DB, Docker, proxy, firewall, DNS, SSL, secret, destructive cleanup, or live system mutation.

## Deadlock Inversion

Previous RUN `RUN-AGENTHUB-UNIVERSAL-MICROSERVICE-SCOPE-BROKER-20260612` was blocked after command-worker validation hit `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` and the same RUN state no longer allowed sandbox dispatch.

PackFix created fresh validation RUN `RUN-AGENTHUB-UNIVERSAL-MICROSERVICE-SCOPE-BROKER-20260612-PACKFIX-VALIDATION`, linked to AH-748, not a duplicate parent task.

## AgentHub Evidence

- `agent_hub_create`: PASS, sandbox root `@agenthub-runs/agenthub-universal-microservice-scope-broker-packfix-validation-20260612`.
- `agent_hub_dispatch`: PASS, adapter `sandbox`, worker `AH748-packfix-sandbox-validator`, spawn receipt `mcp-sandbox-dispatch:49f4394c0211d54146dab2b3`.
- `agent_hub_execute`: PASS, output SHA-256 `1ba6ccc4ed7ac579669ab3e2e662ada42d9200b7fcb95bb9fb37b5b6501e23a7`, `path_safety_gate=PASS`, `secret_redaction_gate=PASS`, `no_forbidden_zone_touched=true`, `client_project_write=false`.
- `agent_hub_merge`: SUCCESS, `done_allowed=true`, ledger SHA-256 `111e526f0ad0551686c84e02914a81588c2bbbbb7931fe12e5293a098b5a8916`, `blocking_residuals=[]`.

## Repository Validation Readback

GitHub readback confirmed PR #159 contains:

- `governance/agenthub-universal-microservice-scope-broker-policy.md`
- `schemas/agenthub_microservice_descriptor.schema.json`
- `schemas/agenthub_permission_lane_receipt.schema.json`
- `schemas/agenthub_packfix_event.schema.json`
- `validators/universal_microservice_scope_broker_validator.rb`
- `validators/runtime_done_truth_validator.rb`
- `evals/universal-microservice-scope-broker/fixtures.json`
- `runbooks/universal-microservice-self-healing-runbook.md`
- `prompts/implementation/agenthub-universal-microservice-worker-dispatch.txt`
- `reports/receipts/AGENTHUB-UNIVERSAL-MICROSERVICE-SCOPE-BROKER-RECEIPT-20260612.md`
- `reports/patches/AGENTHUB-UNIVERSAL-MICROSERVICE-SCOPE-BROKER-REGISTER-PATCH-20260612.diff`

Validator source readback:

- `universal_microservice_scope_broker_validator.rb` checks descriptor required fields, unknown-service read-only discovery surfaces, and Lane 6 gate for destructive surfaces.
- `runtime_done_truth_validator.rb` rejects Done from weak evidence and requires user outcome proof, YouTrack Stage=Done readback, and zero open PackFix for Done cases.

Fixture readback includes negative `reject_http_only_done`, positive `accept_web_ui_done_with_user_outcome`, and negative `reject_open_packfix` cases.

## Result

`LIVE_WORKER_AUTHORITY_MISSING_AFTER_PACKFIX` is closed for AH-748 validation-route scope. Remaining runtime/browser/user-outcome proofs are not required for this repository governance package and remain enforced for future service tasks by the installed validators.

## Safety

No secrets printed. No raw env dump. No live runtime mutation. No VPN touched.
