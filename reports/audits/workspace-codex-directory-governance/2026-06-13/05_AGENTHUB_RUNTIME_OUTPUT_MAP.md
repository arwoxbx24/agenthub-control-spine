---
artifact_id: workspace-codex-directory-governance-agenthub-runtime-map-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# AgentHub Runtime Output Map

## Run Roots

- `@agenthub-state/runs`: active and recent AgentHub run outputs.
- `@agenthub-state/runs-archive`: archived legacy run outputs.
- `@runtime/runtime-state`: hardlock, path-safety, and hook-runtime receipts.

## Observed Naming Risk

The run list contains repeated families such as retry, final, patch, fix, worker-route, and timestamp suffixes. This is evidence of uncontrolled retry growth unless every run has parent task, terminal receipt, and lifecycle state.

## Source Of Truth Ranking

1. YouTrack task state and comments.
2. Control-spine registered artifacts.
3. AgentHub route receipts.
4. Runtime hook receipts.
5. Worker sandbox outputs.
6. Shell output only as raw evidence, never closure proof.

## Required Control

Install run-output lifecycle ledger:

- owner task;
- RUN_ID;
- worker id;
- branch/repo;
- lifecycle: active, evidence, superseded, quarantine, transient;
- deletion/quarantine recommendation;
- default_load false for run outputs;
- safe_to_replay false except explicit reusable fixtures.
