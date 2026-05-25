---
artifact_id: agenthub-access-audit-and-live-devops-enablement-runbook
artifact_type: runbook
owner_role: T1 Architecture Broker
source_task: AH-554
related_tasks:
  - AH-536
  - AH-537
run_id: AGENTHUB-P0-ACCESS-RIGHTS-AUDIT-LIVE-DEVOPS-ENABLEMENT-20260525
created_at: 2026-05-25
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Access Audit And Live DevOps Enablement

## Trigger

Use when AgentHub live work is stuck between false permission loops and valid
runtime safety gates.

## Phase 1: Lineage Freeze

1. Reuse current parent task and child task.
2. Search duplicates before creating any microtask.
3. Do not create new RUNs when existing RUN evidence can carry the work.
4. Parent closure waits for child implementation state.

For this incident:

- parent: AH-536;
- live repair child: AH-554;
- old scoped route evidence: AH-537;
- excluded service task: AH-521 for OpenClaw/claw.

## Phase 2: Access Audit

Record:

- repo access and PR queue state;
- YouTrack task workflow and child links;
- AgentHub MCP tool receipts;
- live worker inventory and authorization status;
- evidence transport status and fallback channels;
- endpoint matrix and exclusions;
- exact permission classes P0-P9 needed.

## Phase 3: Blocker Split

Classify each blocker as one of:

- `FALSE_GLOBAL_BLOCKER`
- `VALID_LOCAL_SAFETY_GATE`
- `WORKER_AUTH_MISSING`
- `TOOL_ADAPTER_MISSING`
- `EVIDENCE_TRANSPORT_LOCAL_FAILURE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `TASK_GRAPH_DEFECT`
- `INSTRUCTION_SOURCE_DRIFT`
- `STALE_ARTIFACT_REPLAY_RISK`
- `RUNTIME_INCIDENT_CONFIRMED`

Generic blocked status is invalid.

## Phase 4: Worker Enablement

Preferred route:

1. Bind AH-554 to an existing worker.
2. Grant P4 read and P5 mutate only for named services.
3. Add P8 only for exact proxy host repair.
4. Add P6 only after backup proof if DB is truly required.
5. Write worker authorization and validation contract before action.

If route is missing, update AH-554 with
`AGENTHUB_LIVE_WORKER_AUTH_MISSING` and keep repo/task lanes moving.

## Phase 5: Evidence And Closure

Required evidence:

- before/after endpoint matrix;
- worker route receipt;
- rollback/checkpoint receipt for mutations;
- no-secret statement;
- YouTrack readback;
- PR queue state for repo artifacts.

Final user chat stays Russian Caveman `Fact/Action/Left`.
