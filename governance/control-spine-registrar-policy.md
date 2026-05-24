---
artifact_id: control-spine-registrar-policy
artifact_type: governance-policy
owner_role: T0 Control Plane
source_task: AH-523
run_id: RUN-teamlead-control-spine-registrar-20260524
created_at: 2026-05-24
lifecycle_status: current_policy
default_load: false
safe_to_replay: false
---

# Control-Spine Registrar Policy

## Purpose

The Control-Spine Registrar prevents PR tails, reports, prompts, receipts, and
lifecycle records from becoming stale active instructions.

GitHub is an artifact store and PR surface only. YouTrack remains the task
system. AgentHub/Codex MCP remains the execution/control system.

## Design Decision

### Option A: Every Agent Cleans Its Own Artifacts

Rejected. It lets scoped workers modify or delete artifacts outside their task
surface. That creates cross-task ownership drift and makes evidence loss more
likely.

### Option B: One Control-Spine Registrar

Accepted. TeamLead/T0 Registrar owns lifecycle decisions, PR queue register,
archive/quarantine decisions, global baseline/context pack, stale PR closure,
and global `ARTIFACT_REGISTER.md` integrity. Workers may only propose lifecycle
metadata for artifacts they own.

### Option C: No Cleanup, Keep Adding Reports

Rejected. It preserves every tail as active-looking material and causes context
explosion, stale prompt replay, and reports acting as pseudo-governance.

## Registrar Authority

Only TeamLead/T0 Registrar may:

- close stale control-spine PRs;
- classify old reports as `audit_only`, `superseded`, or `quarantine`;
- classify old receipts as `operational_receipt` or `audit_only`;
- classify old prompts as consumed and not safe to replay;
- update global `ARTIFACT_REGISTER.md`, `PR_QUEUE_REGISTER.md`, current context
  pack, and baseline/register files;
- decide archive/delete with evidence.

## Closed-Loop Rule

The Registrar must not interrupt the user for ordinary in-scope blockers. Missing
proof becomes a same-run microtask when it concerns:

- missing `INDEX.md`, `ARTIFACT_REGISTER.md`, or `PR_QUEUE_REGISTER.md`
  coverage;
- missing receipt, validation summary, task readback, or PR queue decision;
- stale prompt replay risk;
- conflicting report lifecycle status;
- duplicate PR branch, duplicate report, or duplicate receipt;
- stale PR state that can be closed with evidence.

The Registrar may stop only for owner-only blockers:

- `REVIEW_REQUIREMENT_BLOCKS_MERGE`;
- `SECRET_OR_TOKEN_MISSING`;
- `PRODUCTION_MUTATION_AUTHORITY_MISSING`;
- `DESTRUCTIVE_ACTION_APPROVAL_REQUIRED`;
- `PAYMENT_OR_ACCOUNT_OWNER_REQUIRED`;
- `LEGAL_OR_SECURITY_APPROVAL_REQUIRED`.

Even for owner-only blockers, the Registrar must finish all safe repository
work first and record the blocker in YouTrack, `PR_QUEUE_REGISTER.md`, the
receipt, and the PR body.

Scoped workers may:

- write their assigned task report/receipt;
- propose lifecycle metadata for their own artifacts;
- update `INDEX.md` and `ARTIFACT_REGISTER.md` only for their owned artifacts
  when the task explicitly permits it;
- never archive, delete, quarantine, or supersede unrelated artifacts.

## Lifecycle States

Canonical lifecycle states:

- `current_policy`: current governance policy.
- `active_control`: active control or runbook.
- `current_context_pack`: the single default context pack.
- `current_baseline`: register or baseline that future agents may read by
  default.
- `operational_receipt`: current task proof; not a default instruction.
- `audit_only`: historical evidence; not default context.
- `superseded`: replaced by another artifact or merged evidence.
- `quarantine`: unsafe, conflicting, or stale replay risk.
- `deleted_policy_violation`: removed only because retention would preserve
  unsafe material.

Compatibility states already used in older records (`active_policy`,
`active_runbook`, `historical_receipt`, `consumed_prompt`, `quarantined`) remain
readable, but new registrar decisions should use the canonical states above.

## Default Read Set

Future agents must start with:

1. `AGENTS.md`
2. `INDEX.md`
3. `ARTIFACT_REGISTER.md`
4. `PR_QUEUE_REGISTER.md`
5. `context/agenthub-current-context-pack.md`
6. current task-specific artifacts named by YouTrack or AgentHub

Agents must not bulk-read `reports/`, `reports/receipts/`, `reports/handoffs/`,
or one-time prompts by default.

Reports are evidence, not instructions. Receipts are proof, not prompts.
Prompts are safe to replay only when the register says `safe_to_replay=true`.

## PR Queue Rule

Every open PR must have a queue decision:

- `MERGE_READY`
- `NEEDS_REBASE_OR_REVALIDATION`
- `SUPERSEDED_CLOSE`
- `CONFLICTS_WITH_MAIN`
- `DUPLICATE_ARTIFACT_TAIL`
- `BLOCKED_BY_REVIEW_REQUIREMENT`

Stale PRs must be closed only after `PR_QUEUE_REGISTER.md` and the receipt state
why useful evidence is already on main or represented in the current registrar
PR.

Target queue shape:

- one Registrar/control-spine PR for registers, lifecycle, receipts, and queue;
- at most one implementation/product PR per active implementation task.

## Delete and Quarantine Rule

Delete only secret material, unredacted chat/session dumps, environment data
dumps, credential files, history-navigation links, or duplicate garbage with no
evidence value.

Retain useful history as `audit_only`, `operational_receipt`, or `superseded`.
Quarantine unsafe prompts instead of deleting them unless they contain material
that retention would expose.
