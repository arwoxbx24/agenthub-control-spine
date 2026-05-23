---
artifact_id: agenthub-current-context-pack
artifact_type: current-context
owner_role: T1 Architecture Broker
source_task: AH-PR16-LIFECYCLE-CORRECTION-20260523
run_id: RUN-pr16-lifecycle-correction-20260523
created_at: 2026-05-23
lifecycle_status: current_context
read_by_default: true
safe_to_replay: false
supersedes: none
superseded_by: none
canonical_decision_ref: self
status: active
---

# AgentHub Current Context Pack

## Read First

- Canonical repository: `arwoxbx24/agenthub-control-spine`.
- Default context: `AGENTS.md`, `INDEX.md`, this file, and only current
  task-specific active controls.
- GitHub stores artifacts only. YouTrack remains the task system.
  AgentHub/Codex and approved MCP routes remain the execution environment.

## Current Control Rules

- T0 is intake, routing, validation, and final summary only.
- T0 does not implement product/runtime changes or use urgency as permission to
  bypass worker ownership.
- Done/PASS/success requires implementation evidence, validation evidence,
  receipt evidence, task readback when task state is in scope, and no active
  blocker.
- Missing in-scope proof becomes a same-run bounded microtask.
- Blockers must be classified before final output.

## Active Controls

- `governance/artifact-lifecycle-and-retention-policy.md`
- `governance/agenthub-global-role-and-closure-control.md`
- `governance/teamlead-t0-emergency-stop-control.md`
- `governance/agenthub-single-ingress-control.md`
- `runbooks/agenthub-global-control-loop-closure.md`
- `runbooks/teamlead-t0-role-drift-emergency-stop.md`
- `schemas/agenthub-global-control-receipt.schema.json`
- `schemas/task-service-payload-builder-contract.schema.json`
- `schemas/service-dependency-graph.schema.json`

## Forbidden Default Reads

Do not load all `reports/`, `reports/receipts/`, `reports/incidents/`,
`reports/handoffs/`, `reports/security/`, `reports/apps/`, `prompts/`, or `apps/`
by default. Load them only for task-specific audit evidence.

## Historical Evidence Handling

- Implemented reports are evidence, not current instructions.
- Receipts prove a past state; they do not define future behavior.
- Consumed prompts are not replayed unless reauthorized and conflict-checked.
- If an artifact appears active but conflicts with this context pack, stop with
  `STALE_REPORT_OR_PROMPT_CONTEXT_RISK` and repair lifecycle metadata first.

## Blockers

- `STALE_REPORT_OR_PROMPT_CONTEXT_RISK`
- `CONSUMED_PROMPT_REPLAY_BLOCKED`
- `CURRENT_CONTEXT_PACK_MISSING`
- `LIFECYCLE_METADATA_MISSING`
- `WORKER_ROUTE_UNAVAILABLE_NOT_BLOCKING_REPO_ARTIFACT_REVIEW`
