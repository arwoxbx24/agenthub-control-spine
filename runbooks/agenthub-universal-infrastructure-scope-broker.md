---
artifact_id: agenthub-universal-infrastructure-scope-broker-runbook
artifact_type: runbook
source_task: AH-772
run_id: RUN-AGENTHUB-UNIVERSAL-INFRASTRUCTURE-SCOPE-BROKER-20260612
created_at: 2026-06-12
lifecycle_status: active_control
---

# Universal Infrastructure Scope Broker Runbook

## Intake

1. Bind one YouTrack task and one RUN_ID.
2. Run duplicate check by scope signature.
3. Classify global architecture vs service-local repair.
4. If global, reject service-specific hardcoding.

## Descriptor

Create or read a universal microservice descriptor with `service_id`, `project_root`, `component_type`, docs URL, local guide path, data/auth/network/UI/health/rollback surfaces, allowed operations, forbidden operations, and required evidence.

## Docs

Build a docs source packet for each concrete product/tool. Generic docs packets are allowed for control-plane policy only; live service mutation requires service-specific official docs.

## Authority

Issue the narrowest authority envelope:

- Lane 0 read/docs/inventory;
- Lane 1 artifacts/registers;
- Lane 2 validators/tests;
- Lane 3 sandbox/rehearsal;
- Lane 4 live read;
- Lane 5 reversible live repair;
- Lane 6 controlled destructive/state mutation;
- Lane 7 owner-only irreversible gate.

## PackFix

Convert routine blockers to same-RUN PackFix. Stop after two identical failed attempts and create architecture repair, not a third retry.

## Sandbox

Before live mutation, rehearse when feasible. Docker Compose rehearsal uses isolated project name, optional profiles, non-conflicting ports, health checks, and no live volumes unless explicitly read-only.

## Validation

Validate only applicable layers and record skips:

- docs packet;
- local guide;
- descriptor;
- secret-handle metadata;
- sandbox or reason not feasible;
- process/container health;
- API behavior;
- browser outcome for UI;
- network/public route;
- data integrity where applicable;
- scheduler/worker state;
- rollback/checkpoint;
- YouTrack readback;
- GitHub/VCS binding;
- no-secret scan.

## Done

Done requires evidence matching the actual requested outcome. PR merged is not YouTrack Done. Prompt installed is not route installed. HTTP 200 is not UI Done.