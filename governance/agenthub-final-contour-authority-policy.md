---
artifact_id: agenthub-final-contour-authority-policy
artifact_type: active_policy
source_task: AH-765
run_id: RUN-AGENTHUB-AUTHORITY-LIFECYCLE-EXPANSION-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Final Contour Authority Policy

## Purpose

AgentHub must not finalize routine missing-route blockers such as
`RUNTIME_TOOL_INSTALLATION_REQUIRED`, `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`,
`PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`, `T0_DIRECT_AUTHORSHIP_DEFECT`, or
`VALIDATOR_EXECUTION_NOT_RUN` as owner-facing terminal states. They become
same-RUN PackFix repairs with scoped lane authority.

## Lanes

- Lane 0: T0 control plane routes, verifies, and communicates terminal state.
- Lane 1: control-spine artifact worker writes scoped policy/schema/validator
  artifacts and registers.
- Lane 2: validator execution worker runs declared read-only checks with
  task/RUN context.
- Lane 3: task-service worker updates existing tasks and stage readback.
- Lane 4: model truth worker proves actual model execution or records an
  owner-only audit blocker.
- Lane 5: microservice read/probe worker collects read-only evidence.
- Lane 6: scoped live repair worker acts only with target descriptor and
  rollback.
- Lane 7: destructive worker requires explicit owner approval or replacement
  proof.

## Inversion Rules

- Missing runtime route -> `INSTALL_MISSING_RUNTIME_TOOL_ROUTE`.
- Contract-only dispatch block -> scoped worker authority envelope.
- Missing issue id -> task context injection.
- T0 authorship defect -> dispatch a scoped worker or register same-RUN
  fallback evidence through MCP.
- Validator not run -> install validator execution route and canary.

Third identical routine blocker is forbidden. The authority broker must install
or register the missing route, prove it with canary/fallback evidence, then
continue the same RUN.

## Done

Done requires AgentHub merge `status=SUCCESS`, `done_allowed=true`,
`validation=true`, `receipt=true`, no blocking residuals, and YouTrack readback
showing `Stage=Done`.
