---
artifact_id: adr-no-interaction-task-first-closed-loop-20260531
artifact_type: architecture-decision-record
source_task: AH-P0-NO-INTERACTION-TASK-FIRST
run_id: RUN-P0-NO-INTERACTION-TASK-FIRST-20260531
status: active
default_load: false
safe_to_replay: false
---

# ADR: No-Interaction Task-First Closed Loop

## Context

AgentHub already has task-first, closed-loop recovery, Codex-native routing, and
API/documentation-first controls. The missing durable slice is a dedicated
no-interaction package that validates active-run user message buffering,
technical assignment before mutation, no-mid-cycle user chat, and parent/child
Done behavior in one regression suite.

## Options

### Option A: Conservative Patch

Add prompt wording that says agents should stop sending progress messages.

Decision: rejected. Prompt-only control is weak and does not give validators,
schemas, or acceptance evidence.

### Option B: Balanced Two-Level Closed Loop

Install a repository policy, technical assignment template, run user-input queue
schema, validator, fixtures, receipts, and register coverage. Keep user-facing
output terminal-only while backend tasks continue through receipts.

Decision: selected. It is enforceable, low-risk, and fits the existing
control-spine architecture.

### Option C: Full Policy-as-Code Runtime Enforcement

Implement fail-closed runtime message suppression and policy firewall in the
AgentHub runtime itself.

Decision: deferred unless current runtime work is explicitly scoped. It is
stronger but higher risk and outside this repository-only governance task.

## Consequences

Positive:

- mid-cycle user messages are machine-classified instead of becoming stops;
- mutation cannot proceed without task and technical assignment gates;
- parent Done with open children is rejected deterministically;
- routine blockers become remediation work instead of owner interruptions.

Negative:

- runtime-level suppression is documented and tested synthetically but not
  patched in live runtime in this repository-only run;
- task-service physical readback can still depend on platform availability.

## Residual Risks

- If the AgentHub runtime ignores repository controls, Option C remains a
  follow-up platform remediation task.
- If YouTrack API/MCP is unavailable, repository controls can only record the
  exact task-service blocker; they must not fake task Done.

## Rollback

Revert the files installed by this run and remove their register entries. This
does not touch runtime, product services, DB, Docker, proxy, firewall, DNS, or
secrets.

## Review Date

2026-06-14.
