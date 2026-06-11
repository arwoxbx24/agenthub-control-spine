---
artifact_id: agenthub-scoped-autonomy-lane6-destructive-proof-profile
artifact_type: governance-policy
owner_role: T1 Architecture Broker
source_task: AH-738 / PR152 follow-up
run_id: RUN-AGENTHUB-SMART-SELF-HEALING-AUTHORITY-ELEVATION-20260611
created_at: 2026-06-11
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Lane 6 Destructive Proof Profile

Lane 6 is the only lane that may authorize destructive cleanup.

## Required proof bundle

- exact target id, name, or path
- target class: branch, artifact, container, image, volume, service, app, db, config
- reason for deletion
- dependency check result
- environment class: production, staging, test, scratch, or unknown
- replacement proof, backup proof, or explicit owner confirmation
- rollback path or explicit irreversible declaration
- post-delete validation target
- receipt path

## Allow rules

Deletion is allowed only when one of these is true:

1. owner explicitly confirms deletion of the exact target
2. replacement is installed and validated, and old target is proven unused
3. backup or snapshot exists and restore path is documented
4. target is test, stale, temporary, or audit-only and has lifecycle proof

## Hard denials

- no destructive delete of production DB, volume, or primary runtime without owner confirmation or verified replacement and backup proof
- no broad Docker prune, reset, or delete
- no delete based only on age or naming guess
- no secret or raw env output inside receipts
