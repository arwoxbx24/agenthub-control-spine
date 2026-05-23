---
artifact_id: context-pack-default-agenthub-control-spine
artifact_type: context-pack
owner_role: T1 Architecture Broker
source_task: AH-CONTROL-SPINE-LIFECYCLE-20260523
created_at: 2026-05-23
last_reviewed_at: 2026-05-23
lifecycle_status: active
execution_status: pass
load_policy: default
safe_to_replay: false
supersedes: none
superseded_by: none
canonical_decision_ref: governance/control-spine-current-baseline.md
status: active
---

# Default AgentHub Control-Spine Context Pack

## Load By Default

1. `AGENTS.md`
2. `INDEX.md`
3. `ARTIFACT_REGISTER.md`
4. `governance/control-spine-current-baseline.md`
5. Task-specific active controls referenced by the current request.

## Load Only When Task-Specific

- `governance/*` beyond the current baseline.
- `runbooks/*`.
- `schemas/*`.
- `skills-drafts/*`.
- `prompts/*` that are active and safe to replay.
- `apps/*` implementation files.

## Excluded From Default Load

- `reports/`.
- `reports/receipts/`.
- `reports/handoffs/`.
- `reports/incidents/`.
- `reports/security/`.
- `reports/apps/`.
- Any prompt or draft with `safe_to_replay=false`.

## Rule

If an agent needs an excluded artifact, it must name the task-specific reason and
load only the minimum file set needed for the current audit or implementation.
