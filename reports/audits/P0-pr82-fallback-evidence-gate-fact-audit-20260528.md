---
artifact_id: p0-pr82-fallback-evidence-gate-fact-audit-20260528
artifact_type: audit_report
owner_role: T1 Architect / Model Router Controller / Verifier
source_task: AH-590
run_id: RUN-P0-PR82-FALLBACK-GATE-20260528
created_at: 2026-05-28
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P0 PR82 Fallback Evidence Gate Fact Audit

## Scope

Post-merge control-spine audit for PR #82 and PR #83. Scope is limited to
model-router/action-policy governance files, fixtures, reports, receipts, and
registers. No product, runtime, Docker, NPM, DB, proxy, firewall, DNS, SSL, or
service mutation is in scope.

## Required Questions

| Question | Answer |
|---|---|
| Does the residual exist in main right now? | Yes. Main after PR #83 still allowed a T2 fallback model when `fallback_reason` was merely non-empty. |
| Which exact file/function allows it? | `validators/agenthub_action_policy_validator.rb`, `decision(input)`, profile branch `T2_CODEX_IMPLEMENTER`. |
| Which input shape passes incorrectly? | `actor_role=T2_CODEX_IMPLEMENTER`, `authority_profile=T2_CODEX_IMPLEMENTER`, mutation action such as `CONFIG_EDIT`, `model_class=CODEX_CAPABLE`, `worker_model=gpt-5.4-mini`, non-empty `fallback_reason`, and no `codex_available=false`, no primary-unavailable evidence ref, no `same_run_fallback`, or mismatched `fallback_run_id`. |
| Which eval currently fails or is missing? | Missing regression coverage for `BLOCK_FALLBACK_REASON_ONLY`, `BLOCK_FALLBACK_DIFFERENT_RUN`, separate missing surface outcomes, and non-Codex model denial at the action-policy validator boundary. |
| What is the minimal safe patch? | Add deterministic fallback evidence checks to `agenthub_action_policy_validator.rb`; allow the evidence fields, including explicit `fallback_model`, in `agent-action-request.schema.json`; add focused positive/negative action-policy fixtures; update audit, receipt, index, artifact register, and PR queue. |

## Patch Decision

Residual confirmed. The safe patch is narrow and keeps existing T0 denial,
role-profile matching, owner gates, and non-code role behavior intact while
adding action-boundary proof that fallback stayed in the same RUN after a
primary Codex/Spark unavailable condition and used an approved fallback model.

## Expected Outcomes

- `ALLOW_CODEX_PRIMARY_WITH_SURFACE_EVIDENCE`
- `ALLOW_SAME_RUN_FALLBACK_WITH_PRIMARY_UNAVAILABLE_EVIDENCE`
- `BLOCK_FALLBACK_REASON_ONLY`
- `BLOCK_FALLBACK_DIFFERENT_RUN`
- `BLOCK_MISSING_ALLOWED_SURFACES`
- `BLOCK_MISSING_FORBIDDEN_SURFACES`
- `BLOCK_NON_CODEX_MODEL_FOR_CODE_MUTATION`
- `BLOCKED_T0_DIRECT_AUTHORSHIP`
