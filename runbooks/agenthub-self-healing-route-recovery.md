---
artifact_id: agenthub-self-healing-route-recovery
artifact_type: runbook
owner_role: T2 Route Repair Worker / Registrar / Verifier
source_task: AH-590
run_id: RUN-P0-SELF-HEALING-CORE-20260528
created_at: 2026-05-28
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Self-Healing Route Recovery

## Purpose

Recover ordinary AgentHub route, model, registrar, register, task-debt, and
evidence attachment defects inside the same RUN before owner escalation.

## Same-RUN Recovery Steps

1. Capture defect as `agenthub_self_healing_event`.
2. Confirm the defect is not owner-only.
3. Bind the event to current `run_id`, `task_id`, and `scope_signature`.
4. Route to the narrow repair worker:
   - `T2_ROUTE_REPAIR_WORKER` for live/worker route gaps;
   - `T2_REGISTRAR_REPAIR_WORKER` for register and PR queue gaps;
   - `T2_MODEL_ROUTE_REPAIR_WORKER` for Codex/model fallback gaps;
   - `T2_TASK_DEBT_REPAIR_WORKER` for duplicate task/PR/RUN gaps;
   - `T2_SECRET_HANDLE_REGISTRAR` for redacted secret-handle metadata.
5. Repair only the missing control-plane artifact or route metadata.
6. Validate the repaired gate.
7. Attach evidence and resume the original run.

## Stop Rules

Stop with exact owner-only gate only when repair needs an inaccessible external
credential, payment, legal approval, destructive global infrastructure action,
irreversible production action outside scope, or new owner-created secret value.

Do not ask for a new prompt to repair a same-RUN ordinary platform defect.
