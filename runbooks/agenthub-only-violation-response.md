---
artifact_id: agenthub-only-violation-response
artifact_type: runbook
owner_role: T0 Control Plane
source_task: AH-534
run_id: RUN-control-spine-agenthub-only-execution-discipline-20260525
created_at: 2026-05-25
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub-Only Violation Response

## Trigger

Use this runbook when an agent runs direct shell/runtime/storage/server commands, writes chat-only status instead of repo evidence, claims Done from a report, or stops after blocker text while a safe remediation route remains.

## Immediate Response

1. Stop direct T0 execution.
2. Classify the violation using the exact invalidation classes from `governance/agenthub-only-execution-discipline.md`.
3. Create or reuse the controlling YouTrack task.
4. Create or reuse the AgentHub RUN_ID.
5. Write or update a control-spine receipt under `reports/receipts/`.
6. Continue through AgentHub if a safe worker route exists.

## Quarantine Invalid Evidence

Invalid evidence stays auditable but cannot be used as Done proof.

Record:

- source task and RUN_ID;
- invalidation class;
- touched surface in redacted form;
- whether runtime/product/server state may have changed;
- why the evidence cannot close the task;
- next remediation microtask or platform task.

Do not paste raw terminal dumps, secrets, env values, private links, or raw transcripts.

## Continue Correctly

If safe route remains:

1. Dispatch a scoped AgentHub worker.
2. Include task id, RUN_ID, worker id, allowed surface, forbidden surface, rollback/checkpoint, validation, and evidence output.
3. Require the worker to write bounded evidence.
4. Validate evidence before merge or Done.
5. Update the receipt and registers.

If the AgentHub execution adapter is unavailable:

1. Use class `AGENTHUB_EXECUTION_ADAPTER_UNAVAILABLE`.
2. Create or update a platform remediation task.
3. Record `READY_BLOCKED_BY_PLATFORM_GATE` in the receipt.
4. Do not fall back to direct shell.
5. Do not ask Andrew for routine clicks.

## Avoid User Interruption

Do not interrupt the user for routine proof gaps. Convert missing receipt, register coverage, PR queue update, validation note, or task writeback into same-run microtasks.

Ask the owner only for irreversible owner-only gates, destructive production authority, legal/security approval, or credentials that cannot be delegated.

## Closure States

The final state must be exactly one of:

- `DONE_WITH_EVIDENCE`
- `READY_BLOCKED_BY_PLATFORM_GATE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `FORBIDDEN_SCOPE_BLOCKER`
- `WRONG_TASK`
