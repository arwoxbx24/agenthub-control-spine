---
artifact_id: agenthub-flexible-authority-broker-policy
artifact_type: active_policy
owner_role: T1 Architect / Verifier
source_task: AH-601
run_id: RUN-AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# AgentHub Flexible Authority Broker Policy

## Lane model

- Lane 0: read-only discovery
- Lane 1: control-spine artifacts
- Lane 2: task-service and board metadata
- Lane 3: browser/user QA
- Lane 4: runtime read / safe config diagnosis
- Lane 5: scoped live repair worker with authority envelope
- Lane 6: destructive/state-changing cleanup with explicit proof
- Lane 7: owner-only irreversible gate

Purpose: determine the concrete authority decision for a workload blocker and prevent
generic `BLOCK` outputs.

Allowed authority decisions:

- `ALLOW`
- `ALLOW_WITH_SCOPED_WORKER`
- `ALLOW_WITH_AUTO_REVIEW`
- `PACKFIX_REQUIRED`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `DENY_FORBIDDEN_SCOPE`

Everything else is rejected.

## Decision mapping

- Routine blockers, missing live-worker route, and missing proof-access paths map to
  `PACKFIX_REQUIRED`.
- Repeated identical blocker in the same RUN (`same_blocker_count >= 2`) maps to
  `ALLOW_WITH_AUTO_REVIEW`.
- Owner-only destructive actions map to `OWNER_ONLY_IRREVERSIBLE_GATE` unless explicit
  `owner_approval` is present.
- Explicitly forbidden surfaces map to `DENY_FORBIDDEN_SCOPE`.
- Owner-only scope with approval maps to `ALLOW_WITH_SCOPED_WORKER`.

## Owner-only final blockers

These are final unless approval is present:

- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `MISSING_ACCOUNT_CREDENTIAL_NO_AGENT_ROUTE`
- `LEGAL_OR_PAYMENT_APPROVAL_REQUIRED`
- `DESTRUCTIVE_PRODUCTION_ACTION_REQUIRES_OWNER_APPROVAL`

## Route repair contract

No resolver may emit generic `BLOCK`.
All generic or unmapped blockers must be translated into one of the allowed
decisions above.
