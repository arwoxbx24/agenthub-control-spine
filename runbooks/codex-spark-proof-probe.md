---
artifact_id: codex-spark-proof-probe
artifact_type: runbook
owner_role: T2 Codex Worker
source_task: AH-601
run_id: RUN-AGENTHUB-CODEX-SPARK-MODEL-ROUTING-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Codex Spark Proof Probe Runbook

## Scope

Use when AH-601 requires strict truth proof for Spark and M2 route execution.

## Procedure

1. Confirm the local run route payload:
   - `route_lane`, `task_class`, `task_id`, `run_id`.
   - `requested_model`, `resolved_model`, `first_attempt_model`, `spark_catalog_visible`.
2. Attempt the local `codex`/adapter probe only in a pre-authorized workspace.
3. Classify probe outcomes before creating receipt status:
   - `PASS`: accepted proof exists and `model_truth_status` becomes `PROVEN`.
   - `FALLBACK_PROVEN`: accepted fallback proof exists.
   - `BLOCKED_AUDIT_ACCESS`: proof access blocked; do not fabricate PASS.
4. If the probe fails at shell-admission stage, record the exact blocker:
   - `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID` for shell/pre-dispatch.
5. If the command adapter cannot dispatch, record:
   - `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`.
6. Do not claim actual Spark execution from env/routing fields:
   - `AGENTHUB_REQUESTED_MODEL`
   - `AGENTHUB_RESOLVED_MODEL`
   - env-only logs
   - validator output.
7. For routing/validation, use:
   - `ruby validators/agenthub_model_router_validator.rb <fixture>`
   - `ruby validators/model_execution_truth_validator.rb <fixture>`
8. Only close as `DONE` if:
   - model route validator case set passes;
   - execution truth validator set passes;
   - one of `PASS`/`FALLBACK_PROVEN` has proof ref + accepted proof type.

## For This Run

- T0 shell pre-dispatch probe blocked:
  `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`.
- Command adapter blocked:
  `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`.
- Final truth state therefore remains:
  `BLOCKED_AUDIT_ACCESS` / `BLOCKED` (no actual Spark proof).

