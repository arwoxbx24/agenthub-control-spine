---
artifact_id: agenthub-backend-only-linear-cycle-runbook
artifact_type: runbook
owner_role: T0 Control Plane
source_task: AH-590
run_id: RUN-P0-FULL-REQ-BACKEND-ONLY-ARCH-20260526
created_at: 2026-05-26
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Backend-Only Linear Cycle Runbook

1. Bind request to one YouTrack task and one RUN_ID.
2. Create or resume checkpoint.
3. Produce requirements ledger or technical assignment when nontrivial.
4. Choose role, permission profile, model route, and methodology.
5. Dispatch scoped worker through AgentHub lifecycle.
6. Store evidence in run artifacts.
7. Mirror final evidence to control-spine.
8. Update INDEX, ARTIFACT_REGISTER, and PR_QUEUE_REGISTER.
9. Run validation and redaction checks.
10. Update YouTrack implementation evidence, validation evidence, receipt, and
    Done gate.
11. Return only final success or exact owner-only blocker to the user.

If any gate fails twice, stop that route and create one architecture repair or
typed blocker receipt. Do not loop.

