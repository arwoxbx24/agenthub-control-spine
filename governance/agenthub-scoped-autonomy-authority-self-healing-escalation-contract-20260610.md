---
artifact_id: agenthub-scoped-autonomy-authority-self-healing-escalation-contract-20260610
artifact_type: governance-policy
owner_role: T1 Architecture Broker / T0 Registrar / Verifier
source_task: AH-738
run_id: RUN-AGENTHUB-SCOPED-AUTONOMY-AUTHORITY-SELF-HEALING-20260610
created_at: 2026-06-10
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Scoped Autonomy Authority And Self-Healing Escalation Contract

## Intent

This contract reduces routine deadblocks by making same-contour platform defects
repairable inside the run before escalating to owner-facing blockers. It keeps
destructive, secret-bearing, production-risk, and irreversible operations as owner-only or Lane 6 gates.

## Lane Model

Lane IDs are zero-based and surface-specific:

- `0` Control-spine communication and report compression.
- `1` Control-spine artifact authorship.
- `2` Repository hygiene and lifecycle.
- `3` Routine platform self-healing.
- `4` Routine scoped runtime read-only diagnostics.
- `5` Scoped runtime repair (non-destructive runtime mutation under T2 worker).
- `6` Destructive/irreversible repair with environment proof.

## Control Principles

- Routine defects in scope `0..5` must be converted into single-retry self-healing
  tasks and a repo/receipt record.
- The same blocker class may be retried once per `scope_signature`.
- If the same blocker repeats after one retry and repair route is missing, create a
  repair defect and stop retrying.
- T0/T1 control-spine artifact actions are allowed inside Lane 1 with explicit
  Lane 1 scope proof.
- Lane 5 requires a scoped T2 runtime profile; Lane 6 additionally requires
  deletion/replace/rollback evidence.
- Secret, broad infrastructure mutation, production DB/service deletion without
  proof remains terminal at owner-only class.

## Rule Set

### Lane 1 — Control-Spine Artifact Authorship

- Scope: prompts, reports, receipts, register/index updates, PR-queue entries.
- Allowed actors: T0_CONTROL, T1_ARCHITECT.
- Remediation: route to same-run control-spine receipt/lifecycle tasks.
- Reclassification: `CONTROL_SPINE_AUTHORSHIP_CLASSIFICATION_REPAIR_REQUIRED` when
  a control-spine artifact action is denied by generic runtime hard-stop logic.

### Lane 3 — Routine Platform Self-Healing

- Scope: missing task id/run id, missing route model, missing task payload field,
  share/publication fallback gaps, status-context mapping mismatches, task debt,
  register/readback loops, word-filter rejection, duplicate progress output.
- Remediation outputs:
  - `TASK_ID_SELF_HEALING_REQUIRED`
  - `TASK_CARD_PAYLOAD_REPAIR_REQUIRED`
  - `RUN_STATE_SELF_HEALING_REQUIRED`
  - `MODEL_FALLBACK_RECEIPT_REPAIR_REQUIRED`
  - `SHARE_FALLBACK_TO_REPO_ARTIFACT_REQUIRED`
  - `STATUS_CONTEXT_MAPPING_REPAIR_REQUIRED`
  - `WORD_FILTER_PAYLOAD_REWRITE_REQUIRED`
  - `PROGRESS_OUTPUT_SUPPRESSED_CONTINUE`

### Lane 4 — Routine Runtime Read-Only Diagnostics

- Scope: service/container/runtime health-only checks and evidence collection.
- Allowed actors: T1/T2.
- Remediation output: `T4_ROUTINE_DIAGNOSTIC_ALLOWED` when read-only route,
  evidence evidence, and no mutation scope exist.

### Lane 5 — Scoped Runtime Repair

- Scope: bounded runtime mutation.
- Allowed actors: T2_RUNTIME_REPAIR profile only.
- Remediation output: `SCOPED_T2_RUNTIME_REPAIR_ALLOWED`.
- Blocked when no bound route exists for scoped repair: `NO_SCOPED_T2_ROUTE_FOR_RUNTIME_REPAIR`.

### Lane 6 — Destructive / Irreversible Actions

- Scope: DB/container/service replacement/removal.
- Allowed when Lane 6 proof exists:
  - environment class is non-production or approved exception
  - backup/replacement proof
  - owner confirmation or equivalent production-safe proof
  - dependency scan and rollback proof
- Remediation output: `DESTRUCTIVE_ACTION_PROOF_REQUIRED` when proof is incomplete.

## Recovery Flow

1. Bind task/run/lane/actor/surface before execution.
2. If blocker is routine and within lane `0..5`, emit one repair attempt.
3. On repeated same-blocker, emit typed blocker and repair task.
4. Preserve `MODEL_FALLBACK_RECEIPT_AUTO_WRITTEN` on fallback proof missing.
5. Preserve owner-facing output as final blocker only for terminal gates and
   destructive classes.

## Acceptance

Routine blockers do not terminally block same-contour progress; repeated
same-gate defects produce one repair task. Only terminal owner-only and Lane 6
proof failures remain terminal blockers.
