---
artifact_id: AH-785-permanent-done-gate-hardlock-validation-20260613
artifact_type: validation_report
source_task: AH-785
run_id: permanent-done-gate-hardlock-20260613
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# AH-785 Validation Report

Validation commands attempted by PackFix worker:

- `ruby -c validators/done_evidence_hardlock_validator.rb`
- `ruby validators/done_evidence_hardlock_validator.rb evals/done-evidence-hardlock/fixtures.json`
- static readback for AGENTS.md, INDEX.md, ARTIFACT_REGISTER.md, PR_QUEUE_REGISTER.md rows.

Expected mechanism coverage:

- T0 direct edit -> `BLOCKED_T0_DIRECT_AUTHORSHIP`
- Done without implementation proof -> `BLOCKED_DONE_EVIDENCE_MISSING`
- Done with only GitHub PR -> `BLOCKED_GITHUB_PR_IS_NOT_DONE`
- Done with only curl/status -> `BLOCKED_WEAK_PRODUCT_PROOF`
- Routine validation/browser route missing -> `PACKFIX_CREATED_NOT_OWNER_STOP`
- Parent Done with child open -> `BLOCKED_PARENT_CHILD_DONE_GATE`
- Unauthorized Owner-Closed -> `BLOCKED_OWNER_CLOSED_UNAUTHORIZED`
- Report-only final -> `BLOCKED_REPORT_AS_DONE`
- Fake/synthetic IDs -> `SAFETY_QUARANTINE`
- Old audit_only active replay -> `BLOCKED_STALE_ARTIFACT_REPLAY`
- Progress report while non-terminal -> `MID_CYCLE_PROGRESS_REPORT_BLOCKED`

The executable fixture suite is `evals/done-evidence-hardlock/fixtures.json`.
