---
artifact_id: control-spine-pr-queue-and-artifact-lifecycle-runbook
artifact_type: runbook
owner_role: T0 Control Plane
source_task: AH-523
run_id: RUN-teamlead-control-spine-registrar-20260524
created_at: 2026-05-24
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Control-Spine PR Queue and Artifact Lifecycle Runbook

## Inputs

Read from `main` first:

1. `AGENTS.md`
2. `INDEX.md`
3. `ARTIFACT_REGISTER.md`
4. `PR_QUEUE_REGISTER.md`
5. `context/agenthub-current-context-pack.md`
6. current task-specific artifacts

## Registrar Procedure

1. Confirm canonical repository is `arwoxbx24/agenthub-control-spine`.
2. Confirm YouTrack controlling task and one AgentHub RUN.
3. List open PRs from GitHub readback.
4. Classify every open PR as one of:
   - `MERGE_READY`
   - `NEEDS_REBASE_OR_REVALIDATION`
   - `SUPERSEDED_CLOSE`
   - `CONFLICTS_WITH_MAIN`
   - `DUPLICATE_ARTIFACT_TAIL`
   - `BLOCKED_BY_REVIEW_REQUIREMENT`
5. Record decision in `PR_QUEUE_REGISTER.md`.
6. Update `ARTIFACT_REGISTER.md` for changed or newly discovered artifacts.
7. Close stale PRs only after register and receipt explain why.
8. Validate:
   - `git diff --check`
   - JSON parse for schema changes
   - secret/raw marker scan
   - `INDEX.md` covers current artifacts
   - `ARTIFACT_REGISTER.md` covers all indexed artifacts
   - exactly one current context pack
   - no reports/receipts default-load
   - every open PR has queue decision
   - no runtime/product files changed
9. Update YouTrack with evidence and blocker.

## Worker Rule

Scoped workers may update lifecycle metadata only for artifacts they own. Any
archive, quarantine, deletion, supersession, or global PR queue action must be
sent to TeamLead/T0 Registrar.

## Blockers

Use one blocker:

- `REVIEW_REQUIREMENT_BLOCKS_MERGE`
- `PR_CONFLICT_REQUIRES_REBASE`
- `ARTIFACT_REGISTER_MISSING_AND_CANNOT_WRITE`
- `GITHUB_AUTH_WRITE_UNAVAILABLE`
- `TASK_ID_MISSING`
- `SID_WID_SESSION_ID_NOT_EXPOSED`
- `UNSAFE_SECRET_OR_RAW_TRANSCRIPT_FOUND`
- `LIFECYCLE_DECISION_CONFLICT`
