---
artifact_id: agenthub-self-healing-core-policy
artifact_type: active_policy
owner_role: T1 Architect / Control-Spine Governance
source_task: AH-590
run_id: RUN-P0-SELF-HEALING-CORE-20260528
created_at: 2026-05-28
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Self-Healing Core Policy

## Decision

AgentHub must treat ordinary route, model, registrar, register, task-debt,
session, and policy-field failures as same-RUN platform defects before returning
an owner-facing blocker. Prompt-only controls are not sufficient evidence of
enforcement.

This policy does not grant T0 execution authority. T0 remains a control-plane
role for intake, classification, routing, receipt verification, and final owner
communication. Code, config, shell, Linux, Docker, proxy, DB, firewall, DNS,
product-file, and runtime mutation require a scoped worker authorization
receipt before action.

## Run Loop

Every actionable AgentHub run follows:

1. Capture user intent, task id, RUN_ID, scope signature, and boundary.
2. Classify task class, role, methodology profile, model route, and forbidden
   skills.
3. Authorize with an action authorization receipt before tool or worker action.
4. Route to the role and model allowed by the capability matrix.
5. Act only inside authorized surfaces.
6. Validate task state, artifact state, user outcome where applicable, and
   forbidden-surface non-touch.
7. Record evidence in control-spine and tracker readback.
8. Close only when evidence, register coverage, and receipts are complete.
9. Self-repair ordinary platform defects inside the same RUN before owner
   escalation.

## Self-Repairable Defects

The following are internal remediation events, not final generic blockers:

- `MISSING_LIVE_ROUTE`
- `WORKER_PROFILE_MISSING`
- `MODEL_ROUTE_MISSING`
- `REGISTRAR_PATCH_ROUTE_MISSING`
- `REGISTER_UPDATE_MISSING`
- `TASK_DEBT_DUPLICATE`
- `PR_QUEUE_STATE_MISSING`
- `EVIDENCE_ATTACH_ROUTE_MISSING`
- `INSTRUCTION_SOURCE_DRIFT` when sources are available in control-spine
- `RUN_ID_CASE_MISMATCH`
- `CAPABILITY_MATRIX_FIELD_MISSING`

Each event must include `run_id`, `task_id`, `scope_signature`,
`defect_class`, `remediation_route`, `owner_only`, and `state`.

## Owner-Only Gates

AgentHub stops only for:

- missing external account credential no agent can access;
- payment;
- legal approval;
- destructive or global infrastructure action;
- irreversible production action outside explicit scope;
- new secret value creation by the owner.

The final status must name the exact owner-only gate and evidence for why the
same-RUN repair route cannot resolve it.

## No Generic Blocker Loop

The third unchanged encounter with the same ordinary blocker is a policy defect.
The run must open `SELF_HEALING_ESCALATION` with a bounded remediation owner,
not start another blind retry or ask the owner for a new prompt.

## Backend-Only Owner Output

Owner chat is not the work log. Evidence belongs in control-spine, AgentHub
receipts, PRs, and YouTrack readback. User-facing output remains a short final
summary or an exact owner-only gate.
