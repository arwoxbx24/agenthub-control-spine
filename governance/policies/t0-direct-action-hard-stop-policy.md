---
artifact_id: t0-direct-action-hard-stop-policy
artifact_type: governance_policy
owner_role: T1 Architect / Registrar
source_task: AH-590
run_id: RUN-P0-T0-HARD-STOP-ISOLATION-20260527
created_at: 2026-05-27
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# T0 Direct Action Hard-Stop Policy

## Decision

TeamLead/T0 is a control-plane role only. T0 may classify, route, assign,
verify, register, and update task readback, but must not become a shell, code,
Docker, NPM, database, proxy, firewall, runtime, or product worker.

This policy is a repository control that binds current AgentHub runtime
enforcement installed by the AH-570/AH-554 control packages to the owner
reported 2026-05-27 failure class.

## Pre-Action Deny Classes

When `actor_role=T0_CONTROL`, the following action classes must be denied
before execution:

- `SHELL`
- `COMMAND`
- `CODE_EDIT`
- `PRODUCT_FILE_WRITE`
- `DOCKER`
- `DOCKER_COMPOSE`
- `NPM_PROXY_MANAGER`
- `DATABASE`
- `FIREWALL`
- `DNS_SSL`
- `APP_RUNTIME`
- `SECRET_READ`
- `BROAD_FILESYSTEM_SCAN`
- `PRODUCT_TEST_EXECUTION`

Required denial code: `BLOCKED_T0_DIRECT_AUTHORSHIP`.

## Required Metadata

Every AgentHub action must carry:

- `RUN_ID`
- `task_id`
- `actor_role`
- `worker_role`
- `authority_profile`
- `scope_signature`
- `allowed_surfaces`
- `forbidden_surfaces`
- `evidence_path`
- `receipt_path`
- `secret_redaction_statement`

Missing role or authority metadata must deny before execution with
`ROLE_AUTHORITY_MISSING`.

## Delegation Rule

Implementation, code, config, script, Docker, NPM, runtime, and product work
must be delegated to a scoped worker profile. T0 may open the route and verify
the result, but T0 must not perform the action directly or dispatch an
unscoped command worker that acts as a T0 bypass.

## Enforcement Surfaces

Current control-spine source of truth:

- `governance/permission-profiles/agenthub-permission-validator.md`
- `governance/policies/agenthub/t0-live-root-hard-enforcement-addendum-20260526.md`
- `evals/agenthub-t0-live-root-hard-enforcement/fixtures.json`
- `reports/receipts/P0-t0-live-root-hard-enforcement-addendum-20260526.md`

Runtime install readback is inherited from AH-570 and AH-554 receipts. If a
future runtime readback contradicts those receipts, the correct terminal state
is `T0_PRETOOL_HARD_STOP_NOT_INSTALLED`, not a manual T0 workaround.

## Done Guard

A task may not claim `DONE_WITH_EVIDENCE` for T0 boundary repair unless it has:

- policy artifact coverage;
- negative-test coverage;
- control-spine receipt;
- register coverage;
- YouTrack readback;
- no secret exposure;
- no T0 runtime/product mutation.
