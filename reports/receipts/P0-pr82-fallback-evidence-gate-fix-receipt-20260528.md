---
artifact_id: p0-pr82-fallback-evidence-gate-fix-receipt-20260528
artifact_type: operational_receipt
owner_role: Registrar / Verifier
source_task: AH-590
run_id: RUN-P0-PR82-FALLBACK-GATE-20260528
created_at: 2026-05-28
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# P0 PR82 Fallback Evidence Gate Fix Receipt

RUN_ID: `RUN-P0-PR82-FALLBACK-GATE-20260528`
task_id: `AH-590`
source PRs: `#82`, `#83`
residual_confirmed: true

## Files Changed

- `validators/agenthub_action_policy_validator.rb`
- `schemas/agent-action-request.schema.json`
- `evals/agenthub-x-capability-positive-tests/fixtures.json`
- `reports/audits/P0-pr82-fallback-evidence-gate-fact-audit-20260528.md`
- `reports/receipts/P0-pr82-fallback-evidence-gate-fix-receipt-20260528.md`
- `INDEX.md`
- `ARTIFACT_REGISTER.md`
- `PR_QUEUE_REGISTER.md`

## Gate Results

model-router gate result: fallback model mutation now requires primary
Codex/Spark unavailability proof, an evidence ref, `same_run_fallback=true`,
`fallback_run_id == run_id`, and explicit approved `fallback_model`;
fallback_reason-only approval is rejected.

T0 boundary result: T0 direct authorship remains rejected by existing negative
fixtures and validator path.

register updates: audit and receipt registered in `INDEX.md` and
`ARTIFACT_REGISTER.md`; PR queue readback records PR `#84` merged at
`4818a56f25d19afd13bd45249f15fc689b3cab61`.

YouTrack readback: AH-590 evidence attached through AgentHub task-service
receipt; YouTrack draft `3-623` was updated with scope and validation evidence
because the connector returned a draft id rather than a canonical AH issue id.

## Validation

- action-policy positive/regression eval: PASS, 19 cases
- T0 negative action eval: PASS, 7 cases
- model-token-router eval: PASS, 8 cases
- repo-first receipt gate eval: PASS, 4 cases
- schema and fixture JSON parse: PASS
- git diff check: PASS
- secret scan: PASS, `gitleaks detect --no-git --redact`
- forbidden runtime/product mutation: none performed

final_status: DONE_WITH_EVIDENCE
residuals: none for repository-governance scope
