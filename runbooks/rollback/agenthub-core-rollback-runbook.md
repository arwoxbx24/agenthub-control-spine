---
artifact_id: agenthub-core-rollback-runbook
artifact_type: rollback-runbook
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-570
run_id: RUN-P0-system-permission-core-versioning-20260526
created_at: 2026-05-26
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Core Rollback Runbook

## Trigger

Run this when an AgentHub-core policy, hook, validator, route template, prompt,
or context-builder change causes a loop, role drift, unsafe route, duplicate
task/PR creation, or missing report/register coverage.

## Stop Rule

On owner STOP/DANGER/BLOCK or detector hit:

1. stop mutation;
2. keep safe reporting and task readback enabled;
3. write one quarantine receipt;
4. quarantine the failing artifact under `quarantine/`;
5. roll back to the last validated `agenthub-core.YYYYMMDD.N` release.

## Rollback Preconditions

- source task and run id are known;
- rollback ref is recorded in the core-change receipt;
- affected control surfaces are listed;
- secret redaction is PASS or no content is published;
- one owner/registrar is assigned for the rollback.

## Validation After Rollback

- T0 direct mutation test returns blocked;
- safe report/register action returns allowed;
- missing permission returns manifest;
- repeated blocker returns quarantine;
- YouTrack readback points to the rollback receipt;
- no runtime/product/client services are touched unless a separate T2 profile
  authorizes them.
