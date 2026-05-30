---
artifact_id: codex-native-spawn-subagent-worker-runbook
artifact_type: runbook
owner_role: T2_CODE_AUTHOR
source_task: AH-622
run_id: RUN-P0-CODEX-NATIVE-CAPABILITY-ROUTER-20260530
created_at: 2026-05-30
default_load: false
safe_to_replay: false
---

# Codex Native Spawn/Subagent Worker Runbook

Use this runbook only for AgentHub-controlled Codex-native worker routes.

## Preconditions

1. Bind `task_id`, `parent_run_id`, role, branch, allowed files, forbidden
   surfaces, stop condition, and output artifact path.
2. Confirm the worker role is not `T0_CONTROL`.
3. For code/config/YAML/shell/test/frontend/backend/IaC, request
   `gpt-5.3-codex-spark`.
4. For read-heavy parallel work, request `gpt-5.4-mini` unless another role
   route is explicitly approved.
5. Require a receipt before Done.

## Launch Contract

Every spawned worker prompt or non-interactive execution brief must include:

- `subagent_id` or expected subagent id capture;
- `parent_run_id`;
- `task_id`;
- requested model;
- role;
- allowed files/surfaces;
- forbidden surfaces;
- no secrets/no raw env/no runtime mutation rule;
- output artifact path;
- stop condition;
- validation command or evidence requirement.

## Merge Contract

Accept worker output only when:

1. output artifact exists;
2. artifact hash is recorded;
3. requested/resolved/actual model is recorded;
4. `agenthub-sandbox-worker` is not used as Spark proof;
5. no forbidden surface was touched;
6. secret redaction is `PASS`;
7. validator or reviewer confirms the receipt.

## Stop/Remediation

If a background terminal or subagent is runaway, stop only current-session owned
work and record the stop/remediation path. Unknown ownership becomes a typed
blocker or read-only remediation task, not broad process cleanup.
