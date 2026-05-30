---
artifact_id: P0-t0-escape-C-mid-context-role-drift-20260530
artifact_type: audit_report
source_task: 3-640
run_id: RUN-P0-T0-ESCAPE-ORCHESTRATION-BOUNDARY-AUDIT-20260530
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
created_at: 2026-05-30
---

# Microtask C - Mid-Context Role Drift Audit

## Result

Final state: `ROLE_STATE_REVALIDATION_MISSING`.

## Evidence

- Schemas require `run_id`, `task_id`, `actor_role`, `authority_profile`, action class, surfaces, evidence path, and receipt path.
- Validators check `actor_role` and deny T0 direct runtime/action classes.
- The protected transcript shows a session moving from direct runtime/code actions to later AgentHub MCP calls, without invalidating the earlier T0 work.
- Current evidence does not prove persistent session role binding across every tool call in a mixed long-running conversation.

## Defect

Role state is validated inside selected validators and receipts, but the active session does not prove per-action revalidation of `actor_role` and `actor_model` before every implementation-capable tool call.

## Required Repair

Bind `run_id`, `task_id`, `actor_role`, `authority_profile`, and `actor_model` to the active execution context and revalidate before each mutation-capable action. Silent role switching from T0 to worker must be blocked unless a worker route receipt exists.

## Gates

- no_secret_leak: `PASS`
- no_runtime_mutation: `PASS`
- no_product_code_mutation: `PASS`
