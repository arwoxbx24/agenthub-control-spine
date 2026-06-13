---
artifact_id: closed-contour-user-outcome-worker-template
artifact_type: worker_template
source_task: AH-788
run_id: permanent-user-outcome-validation-governance-20260613
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Closed-Contour User-Outcome Worker Template

## Required Header

- TASK_CLASS:
- ROLE:
- ACTIVE_SKILLS:
- FORBIDDEN_SKILLS:
- SCOPE_SIGNATURE:
- NEGATIVE_MATCHES:
- TASK_ID:
- RUN_ID:
- BRANCH:

Stop before mutation if any header field is missing.

## Workflow

1. Bind task and RUN_ID.
2. Read source of truth and current registers.
3. Declare validation matrix rows in scope.
4. Mutate only assigned files.
5. Run validators/fixtures.
6. For user-visible scope, attach browser/user-story evidence.
7. Build claim ledger. Remove unsupported client claims.
8. Write receipt.
9. Update task with exact Done markers.
10. Move Stage Done only after readback.

## Communication

Ask one focused question only when safe tool discovery cannot answer it. Do not send owner progress reports while the contour is still running. Keep final Russian short.

## Blockers

Routine validation route gaps become same-RUN PackFix. Owner chat is allowed only for owner-only irreversible gates.
