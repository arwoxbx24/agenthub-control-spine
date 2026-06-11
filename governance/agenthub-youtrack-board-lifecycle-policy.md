---
artifact_id: agenthub-youtrack-board-lifecycle-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker / T0 Registrar / T2 YouTrack Worker / Verifier
source_task: AH-743
run_id: RUN-AGENTHUB-YOUTRACK-BOARD-LIFECYCLE-SCOPED-AUTONOMY-20260611
created_at: 2026-06-11
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub YouTrack Board Lifecycle Policy

## Purpose

Every implementation contour must be bound to exactly one YouTrack issue. The issue must move through the board lifecycle before the agent can claim success.

## Canonical lifecycle

1. `Backlog` for unscheduled intake.
2. `Develop` when implementation starts.
3. `Review` when implementation artifacts exist.
4. `Test` when validation starts or completes.
5. `Done` only after implementation evidence, validation evidence, receipt, blocker state, and stage readback pass.

Aliases are accepted only after field or board readback: `dvlog` maps to `Develop`, `preview` maps to `Review`, and closure labels map to `Done`.

## Enforcement rules

- No stage movement means no Done.
- A created issue remains owned by the creating contour until it is closed, linked, superseded, or blocked with a typed blocker.
- Duplicate search must run before new issue creation.
- Routine missing task, run, route, payload, status, and board blockers must trigger same-contour self-healing once before terminal blocker output.
- Issue comments and custom fields must store evidence references instead of owner-chat progress spam.
- Board or issue readback must confirm `Done` before final success.

## Terminal blockers

Use one typed blocker only after repair attempts are exhausted: `YOUTRACK_AUTH_MISSING`, `YOUTRACK_STAGE_FIELD_MAPPING_MISSING`, `YOUTRACK_WORKFLOW_FORBIDS_TRANSITION`, `BOARD_CARD_READBACK_UNAVAILABLE`, `TASK_SERVICE_SCHEMA_REPAIR_FAILED`, `DUPLICATE_OWNER_DECISION_REQUIRED`, or `LANE_PERMISSION_MANIFEST_MISSING`.
