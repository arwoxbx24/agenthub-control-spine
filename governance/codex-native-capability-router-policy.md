---
artifact_id: codex-native-capability-router-policy
artifact_type: active_policy
owner_role: T2_CODE_AUTHOR
source_task: AH-622
run_id: RUN-P0-CODEX-NATIVE-CAPABILITY-ROUTER-20260530
created_at: 2026-05-30
default_load: false
safe_to_replay: false
---

# Codex Native Capability Router Policy

This policy installs a bounded AgentHub route layer for Codex-native execution
capabilities that were proven useful in terminal work. It does not grant T0
implementation authority and does not bypass task, model, scope, permission,
receipt, or Done gates.

## Route Classes

| Route class | Purpose | Required gates |
|---|---|---|
| `CODEX_EXEC_NONINTERACTIVE_WORKER` | Bounded `codex exec` worker runs. | `--model`, role profile, task/RUN binding, receipt, allowed surfaces, no owner manual model selection. |
| `CODEX_SPARK_SPAWN_WORKER` | AgentHub-controlled spawned implementation worker with Spark. | subagent id, parent RUN, task id, requested/resolved/actual `gpt-5.3-codex-spark`, output artifact, hash, safety gates. |
| `CODEX_SUBAGENT_PARALLEL_READONLY` | Parallel bounded read-only exploration, QA, log triage, fixture review, or security scan. | disjoint read scopes, no writes, model route, compact merge output. |
| `CODEX_PROFILED_ROLE_RUN` | `--profile` binds role, model, sandbox, hooks, permissions, and output format. | profile name, role, hooks, sandbox, permission profile, task/RUN. |
| `CODEX_PERMISSION_GUARDED_RUN` | Sandbox and permission controls for writes and sensitive surfaces. | explicit sandbox, allowed dirs/surfaces, denied secret/runtime zones, no YOLO except isolated receipt. |
| `CODEX_MCP_DIAGNOSTIC_RUN` | MCP tool/status proof before MCP-dependent work. | `/mcp` or equivalent diagnostic receipt before dispatch. |
| `CODEX_BACKGROUND_TERMINAL_CONTROL` | Detect and stop runaway current-session background work. | `/ps` or equivalent state check, current-session ownership, safe stop/remediation path. |
| `CODEX_FEATURE_FLAG_CONTROL` | Codex feature enablement such as unified exec. | feature listed, validator coverage, rollback note, no production/runtime mutation. |

## Model Routing

| Role | Primary route | Forbidden |
|---|---|---|
| `T0_CONTROL` | `gpt-5.5` for classification, architecture risk, routing, verification, final output. | code/config/YAML/shell/test authoring, product/runtime mutation, direct worker execution. |
| `T1_ARCHITECT` | `gpt-5.4` or `gpt-5.5` for design and decomposition. | direct implementation mutation. |
| `T2_CODE_AUTHOR` | `gpt-5.3-codex-spark` for code/config/YAML/shell/frontend/backend/test/IaC. | `gpt-5.5`, main/base, sandbox route as Spark proof. |
| `T2_CODE_FALLBACK` | `gpt-5.3-codex` after same-RUN Spark-unavailable proof. | fallback without proof or without `return_to_spark=true`. |
| `T2_FAST_SCAN`, `QA_HELPER`, `LOG_TRIAGE` | `gpt-5.4-mini` for read-heavy bounded work. | implementation writes unless reassigned to T2 code author. |
| `TASK_SERVICE` | deterministic route first; `gpt-5.4-mini` or allowed long-agent route when needed. | Spark burn for task-card text only. |
| `SECURITY_REDACTION` | deterministic scanner first, model second. | raw secret output. |

## Spawn Acceptance

A spawned or subagent worker is accepted only when its receipt records:

- `subagent_id`;
- `parent_run_id`;
- `task_id`;
- requested, resolved, and actual model;
- role is `T2_WORKER`, `T2_CODE_AUTHOR`, `VERIFIER`, `QA`, or `READONLY_TRIAGE`;
- allowed files or surfaces;
- forbidden surfaces;
- output artifact path and hash;
- secret and safety gates;
- final state from the approved taxonomy.

`agenthub-sandbox-worker` is never accepted as Spark proof.

## Conflict And Permission Controls

Parallel subagents may write only when every write surface is explicitly
disjoint. The default parallel route is read-only. Any overlap in file paths or
surfaces blocks the route with `PARALLEL_WRITE_CONFLICT_BLOCKED`.

`danger-full-access` and YOLO-style permission profiles are blocked unless the
task is isolated, has a receipt, and does not touch secrets, Docker, DB, proxy,
firewall, DNS, runtime, PM2, Komodo, or production services.

## Done Gate

`DONE_WITH_CODEX_NATIVE_SPAWN_AND_CLI_GUARDRAILS` requires:

- native Codex router policy installed;
- worker receipt schema installed;
- validator and fixtures pass;
- Spark spawn canary pass;
- read-only parallel subagent canary pass;
- MCP diagnostic canary pass;
- background terminal control canary pass;
- registers updated;
- task readback updated or exact task-service blocker recorded;
- no secret leak;
- no runtime/product mutation;
- no owner manual model selection.
