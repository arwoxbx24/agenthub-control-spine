---
artifact_id: agenthub-live-worker-authority-broker-packfix-autorepair-receipt-20260612
artifact_type: operational_receipt
owner_role: T1 Architecture Broker / T0 Registrar / T2 Worker Authority Broker / Verifier
source_task: AH-748 / PR-159 follow-up
run_id: RUN-AGENTHUB-LIVE-WORKER-AUTHORITY-BROKER-PACKFIX-AUTOREPAIR-20260612
created_at: 2026-06-12
lifecycle_status: active_control_installed
default_load: false
safe_to_replay: false
---

# AgentHub Live Worker Authority Broker + PackFix Autorepair Receipt

## Scope

Installed as PR #159 follow-up for AH-748. Repository control-spine artifacts only.

No VPN, runtime service, DB, Docker, proxy, firewall, DNS, SSL, secrets, destructive cleanup, or live system mutation.

## Installed Artifacts

- `governance/agenthub-live-worker-authority-broker-packfix-autorepair-policy.md`
- `schemas/agenthub_authority_broker_grant.schema.json`
- `validators/live_worker_authority_broker_validator.rb`
- `evals/live-worker-authority-broker/fixtures.json`
- `reports/receipts/AGENTHUB-LIVE-WORKER-AUTHORITY-BROKER-PACKFIX-AUTOREPAIR-RECEIPT-20260612.md`

## Control Result

Routine blocker families are not terminal final blockers by default. They must be converted to PackFix plus Authority Broker plus scoped lane grant plus worker evidence plus receipt.

Owner-only and destructive gates remain hard stops unless exact authority/proof exists.

## AgentHub Route

- RUN_ID: `RUN-AGENTHUB-LIVE-WORKER-AUTHORITY-BROKER-PACKFIX-AUTOREPAIR-20260612`
- sandbox root: `@agenthub-runs/agenthub-live-worker-authority-broker-packfix-autorepair-20260612`
- worker: `AH748-authority-broker-policy-installer`
- adapter: sandbox
- spawn receipt: `mcp-sandbox-dispatch:3b1f72ec82227487bdc79b10`

## Validation

Validator and fixtures installed to enforce:

- routine blocker final output forbidden;
- repeated same-gate third retry forbidden;
- Authority Broker required for routine blockers;
- Lane 6 cannot be silently scoped;
- secret forbidden surface must be explicit in grants.

## Residual

none for repository policy-as-code installation.
