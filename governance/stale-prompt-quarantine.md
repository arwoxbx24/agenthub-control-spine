---
artifact_id: governance-stale-prompt-quarantine
artifact_type: governance-policy
owner_role: T1 Architecture Broker
source_task: AH-494
created_at: 2026-05-22
last_reviewed_at: 2026-05-23
lifecycle_status: superseded
execution_status: not_applicable
load_policy: audit_only
safe_to_replay: false
supersedes: none
superseded_by: governance/artifact-lifecycle-policy.md
canonical_decision_ref: governance/artifact-lifecycle-policy.md
status: superseded
---

# Stale Prompt Quarantine

Old Railway-only, board-UI-hardblock, and broad repair-loop prompts must not be replayed raw. They require a current conflict check against accepted task state before execution.

This policy is superseded by `governance/artifact-lifecycle-policy.md`, which
defines repository-wide prompt replay safety, lifecycle status, load policy, and
quarantine rules.
