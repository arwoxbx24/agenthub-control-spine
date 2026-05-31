---
artifact_id: agenthub-closed-loop-recovery-policy
artifact_type: active_policy
owner_role: T1_ARCHITECT_LEAD_FOR_AGENTHUB_CORE
source_task: AH-P0-CLOSED-LOOP-RECOVERY
run_id: RUN-P0-CLOSED-LOOP-RECOVERY-20260531
created_at: 2026-05-31
default_load: false
safe_to_replay: false
---

# AgentHub Closed-Loop Recovery Policy

AgentHub must complete routine safe work after initial capture without turning
missing proof, PR queue gaps, register gaps, task comments, or validation
routing into owner questions. Routine gaps become same-run remediation tasks or
typed platform blockers.

## Boundaries

T0 is control-plane only: classify, route, register, verify, and summarize. T0
must not author code, mutate product/runtime surfaces, restart services, inspect
secrets, touch databases, or bypass sandbox and approval controls.

Implementation and repair work must be performed by scoped workers with task,
RUN, role, model, allowed scope, forbidden scope, output artifact, hash,
validation, and redaction evidence.

## Closed Loop

Required closed-loop phases:

1. capture and duplicate check;
2. route and ownership binding;
3. worker dispatch with role and model proof;
4. validation and red-team checks;
5. tracker and register update;
6. PR queue update and merge/readback where applicable;
7. final owner receipt only.

Owner interruption is allowed only during capture when confidence is below 7/10
and the missing information cannot be safely inferred, or at an owner-only
irreversible gate.

## Spawned Worker Dispatch

`SPAWNED_WORKER_DISPATCH` is the canonical auditable concept for native Codex
spawned/subagent work. Every event must include requested, resolved, and actual
model proof. Requested model text alone is not evidence. If Spark is requested
and actual model is `agenthub-sandbox-worker`, the result is
`CODEX_SPARK_ACTUAL_MODEL_NOT_PROVEN`.

Parallel subagents default to read-only audit, QA, triage, and summarization.
Parallel write-heavy workers require disjoint surfaces and explicit merge
coordination.

## Codex CLI Controls

Local Codex CLI facts verified by safe local help output:

- `codex exec` supports non-interactive runs.
- `--model`, `--profile`, `--sandbox`, `--ask-for-approval`, `--config`,
  `--strict-config`, `--json`, and `--output-last-message` are available.
- `codex mcp`, `codex mcp-server`, `codex plugin`, `codex doctor`,
  `codex sandbox`, `codex features`, `codex apply`, `codex resume`, and
  `codex fork` are available.

Diagnostics and slash-style controls are not backend proof by themselves.
Actual proof requires task/RUN binding and a receipt from the tool or AgentHub
MCP operation.

Dangerous bypass flags are forbidden for AgentHub work.

## Final States

Allowed terminal states:

- `DONE_WITH_EVIDENCE`
- `READY_BLOCKED_BY_PLATFORM_GATE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `FORBIDDEN_SCOPE_BLOCKER`
- `INSTRUCTION_SOURCE_DRIFT`
- `WRONG_TASK_CLASS_BLOCKER`
- `SAFETY_QUARANTINE`

Generic `BLOCKED`, fake `PASS`, metadata-only `DONE`, and PR-only success are
invalid final states.
