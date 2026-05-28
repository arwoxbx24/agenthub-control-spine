---
artifact_id: P0-agenthub-control-plane-deadlock-root-cause-20260528
artifact_type: incident-report
owner_role: T1 Architect / Verifier
source_task: AH-590
run_id: RUN-P0-CONTROL-PLANE-DEADLOCK-DURABLE-FIX-20260528
created_at: 2026-05-28
lifecycle_status: audit_only
safe_to_replay: false
---

# P0 AgentHub Control-Plane Deadlock Root Cause

## Scope

This report records the owner-provided P0 control-plane deadlock contract and the evidence available through AgentHub MCP and the control-spine repository. It does not include secrets, raw command output, service endpoints, or environment data.

## Confirmed Findings

1. Gate schema mismatch remains a valid root-cause class: missing-access blockers must name the exact missing access surface, and generic blocker text is not acceptable.
2. Stale ledger dominance remains a valid root-cause class: control-plane state can diverge when early blocked events are not reconciled against later evidence.
3. T0 hard-stop is required before tool execution, not only in policy text.
4. Model routing remains unproven when a route is blocked before model invocation or when only sandbox evidence exists.
5. Secret delivery requires owner-only handoff outside chat/logs/Git.
6. Backend-only communication requires a hard user-channel output gate.
7. Repeated platform blockers must convert to same-RUN remediation work instead of repeated owner-facing blockers.
8. Artifact lifecycle and PR queue state must prevent stale prompts and receipts from becoming active instructions.

## Route Evidence

A single AgentHub run was created and a scoped sandbox worker was dispatched. The worker produced sandbox evidence only. That evidence is insufficient to install runtime controls, prove Codex Spark execution, or validate durable code/config fixes.

## Required Durable Fix Classes

- Missing-access blocker schema repair.
- Task-service payload normalization.
- Stale ledger residual resolver.
- T0 pre-tool hard-stop enforcement.
- Codex/model execution proof gate.
- Owner-secret handoff channel.
- Backend-only communication gate.
- Blocker-to-remediation conversion.
- Repo-first reporting and lifecycle hygiene.

## Residual Blocker

`ROUTE_GATE_BEFORE_MODEL_INVOCATION`

The available AgentHub route produced only sandbox-worker evidence. A T2 Codex/runtime worker route with actual model execution and code/config mutation authority was not available in this run, so durable runtime controls cannot be honestly claimed installed.

## No-Secret Proof

This report stores no secret values, credentials, tokens, environment dumps, private keys, cookies, session values, host inventory, or raw service paths.
