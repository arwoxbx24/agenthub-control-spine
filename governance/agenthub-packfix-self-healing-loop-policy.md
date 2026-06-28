---
artifact_id: agenthub-packfix-self-healing-loop-policy
artifact_type: active_policy
owner_role: T1 Architecture Broker / Verifier
source_task: AH-748
run_id: RUN-AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# AgentHub PackFix Self-Healing Loop Policy

## Scope

PackFix is used when route/model proof is missing, blocked, unavailable, or
routine in current run.

## Rules

- Any recurring routine blocker emits `PACKFIX_REQUIRED`.
- Same blocker repeated in the same RUN triggers route repair, not owner commentary.
- Owner-only destructive actions stay blocked until owner approves.
- Generic owner chat is not allowed as the final closure action.
- Prompt dumps or non-audited finalization claims are denied.

## Gate outputs

- `PACKFIX_REQUIRED`
- `OWNER_APPROVAL_REQUIRED`
- `ROUTE_REPAIR_REQUIRED`
- `PACKFIX_PASSED`

