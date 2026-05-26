---
artifact_id: agenthub-permission-validator
artifact_type: governance-validator
owner_role: T1 Architect / Verifier
source_task: AH-570
run_id: RUN-P0-system-permission-core-versioning-20260526
created_at: 2026-05-26
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Permission Validator

## Required Inputs

- task id;
- run id;
- requested profile;
- action class;
- allowed scope;
- forbidden scope;
- rollback plan for dangerous actions;
- validation plan;
- evidence path;
- owner-only gate flag;
- redaction statement.

## Decision Rules

1. Safe control-plane actions with `T0_CONTROL_AUDIT`,
   `REGISTRAR_CONTROL_SPINE`, `T1_ARCHITECT_CONTROL`, or `VERIFIER_READONLY`
   pass when task-bound and redacted.
2. Runtime, Docker, DB, proxy, firewall, secrets, product, or client-project
   mutation fails unless a valid `T2_SCOPED_WORKER` or
   `BREAK_GLASS_CONTROLLED` manifest exists.
3. A missing permission produces one manifest, not a duplicate issue, duplicate
   PR, or repeated run.
4. The second repeat of the same blocker without new evidence triggers
   `CONTROL_LOOP_QUARANTINE`.
5. Owner STOP/DANGER/BLOCK messages halt mutation before further tool use.
6. Reports, receipts, and audit artifacts never become standing instructions
   unless `ARTIFACT_REGISTER.md` marks them active policy/control/source.
7. Sandbox-only proof cannot satisfy runtime Done.

## Terminal Outcomes

- `ALLOW_SAFE_CONTROL_ACTION`
- `ALLOW_T2_SCOPED_ACTION`
- `REQUIRE_PERMISSION_MANIFEST`
- `CONTROL_LOOP_QUARANTINE`
- `DENY_T0_DIRECT_MUTATION`
- `DENY_SECRET_OR_DESTRUCTIVE_SCOPE`

## Quarantine Action

On `CONTROL_LOOP_QUARANTINE`:

1. stop mutation;
2. write one quarantine receipt;
3. quarantine the failing prompt/policy under `quarantine/`;
4. roll back to the last validated core release if an installed change caused
   the loop;
5. keep safe reporting and task readback enabled.
