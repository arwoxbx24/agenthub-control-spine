---
artifact_id: adr-no-chat-deadlock-contour-20260531
artifact_type: architecture-decision-record
source_task: AH-P0-NO-CHAT-DEADLOCK-CONTOUR
run_id: RUN-P0-NO-CHAT-DEADLOCK-CONTOUR-20260531
status: active
default_load: false
safe_to_replay: false
---

# ADR: No-Chat Deadlock Contour

## Context

AgentHub already contains no-interaction, boundary/backup, API/docs-first,
Codex-native, and model-route controls. The missing final contour is a compact
validator that proves these controls work together for active-run user deltas,
technical assignment before mutation, forbidden directories, deadlock retry
limits, model/spawn receipts, task-service physical write blockers, and final
output shape.

## Decision

Install a dedicated policy, `USER_DELTA_QUEUE` schema, worker evidence template,
validator, fixtures, audit, receipt, and register coverage. Do not mutate
domain products or live runtime.

## Rejected Alternatives

- Prompt-only tightening: rejected because it cannot block action classes.
- Full runtime firewall mutation: deferred to a separate AgentHub runtime task.
- Hiddify-specific patching: rejected because this is core governance.

## Consequences

The contour now has deterministic regression tests for the 13 observed failure
classes in the corrective prompt. Task-service physical write failures remain
typed blockers when the platform route cannot materialize an issue id.

## Rollback

Revert this run's policy, schema, template, validator, fixtures, audit, receipt,
and register entries. No runtime or product state is changed.
