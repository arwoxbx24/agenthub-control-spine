---
artifact_id: agenthub-permission-broker-lane-authority-policy
artifact_type: active_policy
owner_role: T1 Architecture Broker / Verifier
source_task: AH-763
run_id: RUN-AGENTHUB-DOCS-FIRST-VALIDATOR-ROUTE-PACKFIX-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# AgentHub Permission-Broker Lane Authority Policy

## Objective

Route validators only through task-bound authority envelopes and block
`requested_model`/`resolved_model`/environment-only assertions as proof of
execution.

## Authority Lanes

- Lane 0: discovery and reporting context only.
- Lane 1: control-spine artifacts (`governance/`, `schemas/`, `validators/`, `reports/`).
- Lane 2: YouTrack/task-service coordination.
- Lane 3: runbook and same-RUN closure planning.
- Lane 4: read-only runtime diagnostics and non-mutating checks.
- Lane 5: scoped live repair when authority envelope authorizes worker dispatch.
- Lane 6: destructive/state-changing operations with explicit owner approval and
  evidence.

Other lanes are disallowed unless the authority policy explicitly extends this
package.

## Authority Envelope Contract

Each validator execution attempt must provide an envelope with:

- `run_id`, `task_id`, `scope_signature`, `validator_name`, `validator_path`
- `execution_route` and `route_lane`
- `decision` in:
  - `ALLOW`
  - `ALLOW_WITH_SCOPED_WORKER`
  - `DENY_FORBIDDEN_SCOPE`
  - `PACKFIX_REQUIRED`
  - `ROUTE_REPAIR_REQUIRED`
  - `ALLOW_WITH_AUTO_REVIEW`
  - `OWNER_ONLY_IRREVERSIBLE_GATE`
- `same_blocker_count`, `routine_blocker`, `live_worker_missing`,
  `owner_only`, `owner_approval`, `forbidden_scope`, `destructive_action`
- optional `connector_blockers` list and `blocker_code`

Task binding (`run_id`/`task_id`), route lane, and decision must be present for
validator execution.

## Blocker-to-Decision rules

- `T0_DIRECT_AUTHORSHIP_DEFECT` maps to `PACKFIX_REQUIRED` in normal
  governance/control-spine repair, and escalates to
  `DENY_FORBIDDEN_SCOPE` only when the write target is product code,
  runtime state, secrets, DB, proxy, firewall, or other forbidden scope.
- `DISPATCH_TASK_GATE_MISSING` and
  `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID` map to `PACKFIX_REQUIRED`.
- `YOUTRACK_READBACK_PERMISSION_MISSING`, `GITHUB_CONNECTOR_WRITE_UNAVAILABLE`,
  `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`,
  `CODEX_USAGE_AUDIT_ACCESS_MISSING`, `MODEL_FALLBACK_RECEIPT_MISSING`,
  `VALIDATOR_EXECUTION_NOT_RUN` map to same-RUN repair codes.
- Any other routine blocker without mapped decision is blocked.

Any other blocker must resolve to a schema-valid replacement in the `decision`
set above; generic `BLOCK` is disallowed.

## Routine-Blocker Conversion

The same-blocker repeat rule applies to all validation route gates:

- First occurrence of routine blockers becomes `PACKFIX_REQUIRED`.
- Second identical occurrence (`same_blocker_count >= 2`) becomes
  `ROUTE_REPAIR_REQUIRED`.
- Third occurrence is not routable as PackFix retry in this run.

## Blockers Converted to PackFix in this scope

- `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`
- `DISPATCH_TASK_GATE_MISSING`
- `VALIDATOR_EXECUTION_NOT_RUN`
- `CODEX_USAGE_AUDIT_ACCESS_MISSING`
- `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`
- `YOUTRACK_READBACK_PERMISSION_MISSING`
- `T0_DIRECT_AUTHORSHIP_DEFECT`
- `GITHUB_CONNECTOR_WRITE_UNAVAILABLE`
- `MODEL_FALLBACK_RECEIPT_MISSING`

## Prohibited Proof Forms

Validator execution claims are invalid when tied only to:

- `requested_model` / `resolved_model` / env fields,
- absent authority envelope,
- or proof from untrusted runtime outputs.

For final states (`DONE`, `PASS`) any model-execution claim must be proven
with explicit execution proof artifacts (JSON proof ref + allowed proof type)
rather than route config fields. A no-claim closure must record
`NO_MODEL_CLAIM`.
