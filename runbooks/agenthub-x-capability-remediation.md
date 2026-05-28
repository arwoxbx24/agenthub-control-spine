---
artifact_id: agenthub-x-capability-remediation
artifact_type: runbook
owner_role: Lifecycle Controller / Registrar
source_task: AH-590
run_id: RUN-P0-AGENTHUB-X-CAPABILITY-HARD-ENFORCEMENT-20260528
created_at: 2026-05-28
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub X Capability Remediation Runbook

## Trigger

Use this runbook when a routine action is blocked because no AgentHub X profile,
adapter, hook, validator, or worker route matches the request.

## Rule

Missing routine capability is not a generic owner blocker and is not permission
for T0 direct shell or black-box fallback. It becomes a same-RUN remediation
task unless the blocker is one of the owner-only gates listed in
`governance/agenthub-x-capability-matrix.md`.

## Steps

1. Record `run_id`, `task_id`, `actor_role`, requested action, requested
   surface, and blocker.
2. Classify the missing route as matrix gap, hook path gap, adapter gap, worker
   profile gap, secret-handle gap, or true owner-only gate.
3. If routine, patch the smallest control artifact: matrix, schema, validator,
   eval, worker template, or adapter installer contract.
4. Run negative and positive evals.
5. Update INDEX, ARTIFACT_REGISTER, PR_QUEUE_REGISTER, audit, receipt, and task
   readback.
6. Resume the original RUN. Do not create a duplicate RUN unless the current RUN
   is explicitly quarantined.

## Terminal Typed Blockers

- `AGENTHUB_DISPATCH_HOOK_PATH_REQUIRED`
- `AGENTHUB_EXECUTE_HOOK_PATH_REQUIRED`
- `MCP_ADAPTER_POLICY_PATH_REQUIRED`
- `CODEX_BOOTSTRAP_POLICY_PATH_REQUIRED`
- `TERMINAL_BRIDGE_HOOK_PATH_REQUIRED`
- `LIVE_WORKER_POLICY_INSTALLER_REQUIRED`
- `CONTROL_SPINE_REGISTRAR_PATCH_ROUTE_REQUIRED`
