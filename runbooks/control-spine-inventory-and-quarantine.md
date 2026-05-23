---
artifact_id: runbook-control-spine-inventory-and-quarantine
artifact_type: runbook
owner_role: T1 Architecture Broker
source_task: AH-CONTROL-SPINE-LIFECYCLE-20260523
created_at: 2026-05-23
last_reviewed_at: 2026-05-23
lifecycle_status: active
execution_status: pass
load_policy: task_specific
safe_to_replay: true
supersedes: none
superseded_by: none
canonical_decision_ref: governance/artifact-lifecycle-policy.md
status: active
---

# Control-Spine Inventory And Quarantine

## Procedure

1. Read `AGENTS.md`, `INDEX.md`, `ARTIFACT_REGISTER.md`, and
   `governance/control-spine-current-baseline.md`.
2. Read task-specific active controls only.
3. Inventory artifacts listed in `INDEX.md`.
4. Classify each artifact with lifecycle status, execution status, load policy,
   replay safety, supersession, canonical decision reference, source task,
   review date, and owner role.
5. Extract durable decisions from reports into governance, runbooks, schemas,
   skills, or the current baseline.
6. Mark reports and receipts as `audit_only`.
7. Mark stale prompts as `quarantined` unless they pass a current conflict check.
8. Update `ARTIFACT_REGISTER.md` before or with `INDEX.md`.
9. Keep `INDEX.md` compact; link to the register for lifecycle metadata.
10. Validate and create one receipt.

## Classification Defaults

| Surface | Default lifecycle | Default load policy | Replay |
|---|---|---|---|
| `governance/*` | `active` or `candidate` | `default` or `task_specific` | false unless procedural |
| `runbooks/*` | `active` or `candidate` | `task_specific` | true only when current |
| `schemas/*` | `active` or `candidate` | `task_specific` | false |
| `skills-drafts/*` | `candidate` | `task_specific` | false |
| `reports/incidents/*` | `implemented` after extraction | `audit_only` | false |
| `reports/receipts/*` | proof status | `audit_only` | false |
| `reports/handoffs/*` | `archived` | `audit_only` | false |
| `reports/security/*` | `implemented` or `archived` | `audit_only` | false |
| `prompts/*` | `candidate` or `quarantined` | `task_specific` or `never_load` | false unless active and checked |
| `apps/*` | `implemented` or `candidate` | `task_specific` | false |

## Moving Or Marking Artifacts

Prefer register classification over file moves. Move a file only when:

- the move will not break evidence traceability;
- `INDEX.md` and `ARTIFACT_REGISTER.md` are updated in the same change;
- the old path is recorded as superseded or moved.

Hard deletion requires secret, unsafe retained content, duplicate garbage, or
explicit user authorization.

## Validation

Required checks:

- `git diff --check`;
- JSON schema parse validation;
- scoped secret scan over changed files;
- marker scan for unsafe retained content;
- register coverage for every `INDEX.md` artifact;
- exactly one current baseline artifact;
- no `reports/` artifact with `load_policy=default`;
- no prompt with `safe_to_replay=true` unless active and not superseded;
- GitHub branch and PR readback.
