---
artifact_id: agenthub-locked-run-recovery
artifact_type: runbook
source_task: AH-507
run_id: AH-507-CONTROL-LOOP-RECOVERY-20260523
status: active
---

# AgentHub Locked Run Recovery

## Goal

Recover the control loop without repeating a locked run, creating duplicate tasks, or starting uncontrolled implementation.

## Procedure

1. Read the old run merge report.
2. If the old run is blocked, locked, or has an invalid transition, classify it as superseded.
3. Do not dispatch the old run again.
4. Check for one existing recovery run for the same task and objective.
5. Reuse that recovery run if it exists. Otherwise create exactly one recovery run.
6. Dispatch exactly one scoped worker.
7. Keep product hosting and runtime changes out of the recovery run.
8. Record evidence in the canonical task and receipt.
9. Return one final state only.

## Stop Conditions

- No duplicate YouTrack task is created.
- No second recovery run is created.
- No Railway, proxy, Docker, database, firewall, runtime, secret, tunnel, or production mutation is performed.
- No final PASS is claimed while live ChatGPT validation is missing.
