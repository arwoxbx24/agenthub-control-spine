---
artifact_id: workspace-directory-write-gate-spec-20260613
artifact_type: hook_gate_spec
source_task: AH-787
run_id: workspace-codex-directory-governance-implementation-20260613
lifecycle: active_control
default_load: false
safe_to_replay: false
---

# Workspace Directory Write Gate Spec

## Inputs

`task_id`, `run_id`, `role`, `target_path`, `operation`, `artifact_lifecycle`, `default_load`, `safe_to_replay`, `source_task`, `scope_signature`, `branch`, `pr_state`.

## Deny Rules

Return typed denial before write when target path is outside the directory map, task/RUN is missing, role is T0 and operation mutates repository/runtime/product files, lifecycle metadata is missing, path contains unmanaged temp markers, branch does not match source task/scope signature, open PR already exists without queue state, operation attempts broad cleanup, or write targets `.codex` internals without scoped runtime task.

## Allow Rules

Allow only when map entry exists, role is authorized, task/RUN are present, lifecycle is valid, register coverage is planned, and rollback/receipt path exists.

## Routine PackFix

Missing register row, missing PR queue state, missing parser marker, or missing validation route returns `PACKFIX_REQUIRED`, not owner interruption.
