---
artifact_id: AGENTHUB-FLEXIBLE-AUTHORITY-BROKER-RECEIPT-20260612
artifact_type: operational_receipt
owner_role: T1 Architect / Verifier / REGISTRAR
source_task: AH-601
run_id: RUN-AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# AGENTHUB Flexible Authority Broker and PackFix Receipt

## Scope

Implemented a deterministic flexible authority + PackFix package for AH-601 / AH-748.
New artifacts:

- `governance/agenthub-flexible-authority-broker-policy.md`
- `governance/agenthub-packfix-self-healing-loop-policy.md`
- `schemas/agenthub_authority_envelope.schema.json`
- `schemas/agenthub_packfix_event.schema.json`
- `validators/agenthub_authority_broker_validator.rb`
- `validators/agenthub_packfix_self_healing_validator.rb`
- `evals/flexible-authority-broker/fixtures.json`

## Validation runs

- `ruby validators/agenthub_authority_broker_validator.rb evals/flexible-authority-broker/fixtures.json` — PASS (4)
- `ruby validators/agenthub_packfix_self_healing_validator.rb evals/flexible-authority-broker/fixtures.json` — PASS (3)

## Gate behavior installed

- Routine blockers route to `PACKFIX_REQUIRED`.
- Missing live worker route is a PackFix decision.
- Repeated same blocker twice maps to `ROUTE_REPAIR_REQUIRED` in PackFix self-healing.
- Owner-only destructive DB delete requires explicit owner approval.
- `DENY_FORBIDDEN_SCOPE` is used for explicit forbidden-scope attempts.
