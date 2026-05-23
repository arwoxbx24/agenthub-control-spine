---
artifact_id: artifact-lifecycle-and-retention-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker
source_task: AH-PR16-LIFECYCLE-CORRECTION-20260523
run_id: RUN-pr16-lifecycle-correction-20260523
created_at: 2026-05-23
lifecycle_status: active_control
read_by_default: true
safe_to_replay: false
supersedes: governance/stale-prompt-quarantine.md
superseded_by: none
canonical_decision_ref: context/agenthub-current-context-pack.md
status: active
---

# Artifact Lifecycle And Retention Policy

## Purpose

The control-spine repository must preserve evidence without letting old reports,
receipts, and one-time prompts become active instructions. Reports are evidence,
receipts are proof, and prompts are executable only when explicitly current and
safe to replay.

## Lifecycle States

| State | Meaning |
|---|---|
| `active_control` | Current governance, runbook, schema, or skill that may guide agents. |
| `current_context` | Small read-first context pack agents must load before historical evidence. |
| `task_specific` | Read only when the current task references the artifact. |
| `implemented_audit_only` | Historical report whose findings were promoted into controls. |
| `receipt_only` | Evidence or receipt; never an instruction source. |
| `consumed_prompt` | One-time prompt already executed; `safe_to_replay=false`. |
| `quarantined` | Conflicts with current baseline or is unsafe to replay. |
| `archived` | Retained history, not active context. |
| `superseded` | Replaced by another artifact. |

## Retention And Deletion

Delete only when retention would preserve credential material, verbatim session
logs, environment exports, key material, unredacted protected links, or unsafe
duplicate garbage and deletion is explicitly safe. Otherwise preserve the
artifact as evidence with `read_by_default=false`.

Unsafe prompts are quarantined instead of deleted unless they contain prohibited
content.

## Default Read Rules

Agents read first:

1. `AGENTS.md`;
2. `INDEX.md`;
3. `context/agenthub-current-context-pack.md`;
4. current task-specific active controls.

Agents must not bulk-read `reports/` by default. A report finding becomes a
standing rule only after promotion into active governance, runbook, schema, skill,
or the current context pack.

## Promotion Rule

When a report finding is promoted into durable controls, update `INDEX.md` so the
report is marked `implemented_audit_only` or `receipt_only`, with
`read_by_default=false`. One-time prompts used to create the repair must be marked
`consumed_prompt` with `safe_to_replay=false`.
