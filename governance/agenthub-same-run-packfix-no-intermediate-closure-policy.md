# AgentHub Same-RUN PackFix No-Intermediate Closure Policy

Source task: `AH-777`
Run: `RUN-AGENTHUB-GLOBAL-SAME-RUN-PACKFIX-CLOSURE-20260612`
Prompt: `AGH-PROMPT-20260612-SAME-RUN-PACKFIX-NO-INTERMEDIATE-CLOSURE`
Idempotency key: `AGH:SAME_RUN_PACKFIX:NO_INTERMEDIATE_CLOSURE:GLOBAL:20260612`

## Purpose

AgentHub contours must not finish owner-facing output with routine residual
blockers or "next step" status. Routine blockers are same-RUN PackFix work.
The only terminal contour states are:

- `DONE_WITH_EVIDENCE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `DENY_FORBIDDEN_SCOPE`

## Required Routing Header

Each contour must record:

- `TASK_CLASS`
- `ROLE`
- `ACTIVE_SKILLS`
- `FORBIDDEN_SKILLS`
- `SCOPE_SIGNATURE`
- `idempotency_key`
- `run_id`
- `task_id`

Missing route, validator, register, model-truth, browser, or task-stage proof is
not a final state. It becomes a PackFix item unless it matches a true
owner-only or forbidden-scope gate.

## Routine Blocker Conversion

The following blockers must be converted before any final owner message:

| Blocker | PackFix |
|---|---|
| `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` | `INSTALL_OR_AUTHORIZE_SCOPED_LIVE_WORKER_ROUTE` |
| `YOUTRACK_READBACK_PERMISSION_MISSING` | `INJECT_YOUTRACK_READBACK_CONTEXT_TO_WORKER` |
| `YOUTRACK_DONE_GATE_REPAIR_REQUIRED` | `REPAIR_DONE_GATE_FIELD_MAPPING_AND_STAGE_READBACK` |
| `REGISTER_APPEND_ROUTE_PENDING` | `INSTALL_SAFE_REGISTER_APPEND_ROUTE` |
| `VALIDATOR_EXECUTION_NOT_RUN` | `INSTALL_VALIDATOR_EXECUTION_ROUTE_AND_RUN_CANARY` |
| `RUNTIME_TOOL_INSTALLATION_REQUIRED` | `INSTALL_TASK_BOUND_RUNTIME_TOOL_ROUTE` |
| `MODEL_TRUTH_NOT_PROVEN` | `RUN_MODEL_TRUTH_PROBE_OR_MARK_NOT_PROVEN_WITH_NON_GREEN_STATE` |
| `PUBLIC_ROUTE_FAILURE` | `RUN_BROWSER_AND_ROUTE_LAYER_REPAIR` |
| `SECRET_HANDLE_MISSING` | `SECRET_HANDLE_RESOLVER_BEFORE_OWNER_GUIDE` |
| `SAME_PROMPT_RESUME_FROM_RESIDUAL_PACKFIX` | `RESUME_EXISTING_PACKFIX_AND_CLOSE_RESIDUAL` |

Generic `BLOCKED` is invalid.

## Idempotency

Before execution, the worker must search the current task, RUN ledger, PackFix
ledger, artifact register, PR queue, receipts, validation reports, and PR
history for the prompt id or idempotency key. If already applied, it must not
create another task, RUN, PR, branch, or artifact family. It resumes only open
PackFix residuals. If none remain, terminal state is
`ALREADY_APPLIED_AND_CLOSED`.

## Task Graph Rule

No PackFix child may remain in Backlog or a non-terminal state. Parent Done is
blocked until:

- all child PackFix tasks are terminal;
- implementation evidence exists;
- validation evidence exists;
- receipt exists;
- final task readback says `Done`;
- Done gate says `PASS`;
- no active PackFix remains.

## Owner Output Rule

Owner output is allowed only after terminal proof.

Allowed final success output:

```text
Fact: contour closed; task graph Done readback PASS.
Action: none.
Left: none.
```

Owner-only and forbidden-scope finals must use the corresponding typed terminal
state and must not include routine blocker text as `Left`.

## Red-Team Gate

Done is denied if proof is only a prompt, only a PR, only HTTP 200, only
sandbox output, only requested/resolved model metadata, or if any child PackFix
remains open.
