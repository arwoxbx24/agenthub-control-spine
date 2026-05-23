---
artifact_id: governance-artifact-lifecycle-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker
source_task: AH-CONTROL-SPINE-LIFECYCLE-20260523
created_at: 2026-05-23
last_reviewed_at: 2026-05-23
lifecycle_status: active
execution_status: pass
load_policy: default
safe_to_replay: false
supersedes: governance-stale-prompt-quarantine
superseded_by: none
canonical_decision_ref: governance/control-spine-current-baseline.md
status: active
---

# Artifact Lifecycle Policy

## Purpose

The control-spine repository stores evidence and controls. It must not let old
reports, receipts, prompt drafts, or incident writeups become standing
instructions by accident.

Durable controls live in governance, runbooks, schemas, skills, and the current
baseline. Reports are evidence. Receipts are proof. Prompts are executable only
when explicitly marked active and safe to replay.

## Lifecycle Status

| Status | Meaning |
|---|---|
| `candidate` | Proposed artifact that has not been accepted. |
| `active` | Current control surface or current context source. |
| `implemented` | Evidence source whose durable decisions were extracted into active controls. |
| `superseded` | Replaced by a named artifact or decision. |
| `archived` | Preserved for history; not used by default. |
| `quarantined` | Unsafe to replay or context-load without explicit audit. |
| `deleted-redacted` | Removed because retention would expose unsafe content. |

## Execution Status

| Status | Meaning |
|---|---|
| `not_applicable` | Artifact is policy, index, context, or evidence metadata. |
| `draft` | Incomplete or not adopted. |
| `partial` | Some acceptance gates passed, but closure is incomplete. |
| `blocked` | A typed blocker remains. |
| `pass` | Accepted for its scoped purpose. |
| `failed` | Rejected or invalid for its scoped purpose. |

## Load Policy

| Policy | Meaning |
|---|---|
| `default` | Loaded in the default AgentHub control-spine context pack. |
| `task_specific` | Loaded only when the current task asks for that surface. |
| `audit_only` | Loaded only for audit, incident review, or provenance checks. |
| `never_load` | Do not load into agent context; retain only as redacted index entry or delete if unsafe. |

## Replay Safety

`safe_to_replay=true` is allowed only for active prompts or runbooks that passed
a current conflict check and are not superseded. Reports, receipts, handoffs,
incident writeups, app artifacts, and partial prompts default to
`safe_to_replay=false`.

## Deletion, Archive, And Quarantine

Hard deletion is allowed only for:

- secrets or credential material;
- verbatim session logs or environment exports that should not be retained;
- unredacted internal links or private operational traces;
- duplicate garbage with no audit value;
- explicitly authorized cleanup.

Otherwise, preserve evidence and classify it as `implemented`, `superseded`,
`archived`, or `quarantined`.

## Extraction Rule

A report cannot override current governance. A report decision becomes current
only after it is promoted into an active governance, runbook, schema, skill, or
baseline artifact and the register points to that canonical decision reference.

## Default Context Rule

Agents must not load all reports by default. The default context pack is:

- `AGENTS.md`;
- `INDEX.md`;
- `ARTIFACT_REGISTER.md`;
- `governance/control-spine-current-baseline.md`;
- only task-specific active controls required by the current request.

Reports, receipts, handoffs, incidents, app artifacts, and security reports are
excluded from default load unless a task explicitly asks for audit evidence.
