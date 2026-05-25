---
artifact_id: agenthub-lane-router-and-blocker-scope-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker
source_task: AH-542
run_id: RUN-agenthub-p0-paralysis-breaker-repo-first-control-repair-20260525
created_at: 2026-05-25
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Lane Router And Blocker Scope Policy

## Purpose

This policy prevents a blocker in one AgentHub lane from becoming a global stop
when other lanes can still move safely. It also stops repeated same-gate loops,
task explosion, sandbox-only Done claims, and stale recovery prompt replay.

## Lanes

| Lane | Name | Owns | Valid blocker examples | Non-blocker examples |
|---|---|---|---|---|
| A | Control-spine repo | `AGENTS.md`, `INDEX.md`, registers, runbooks, policies, schemas, prompt quarantine | `CONTROL_SPINE_REPO_ROUTE_MISSING`, `GITHUB_AUTH_MISSING`, `PR_QUEUE_CONFLICT_NEEDS_REBASE` | `LIVE_ADAPTER_ENABLEMENT_REQUIRED` |
| B | YouTrack task graph | dedupe, parent/child rules, stages, blockers, task readback | `YOUTRACK_MCP_UNAVAILABLE`, `YOUTRACK_AUTH_MISSING`, `ISSUE_SCHEMA_MISSING` | Docker runtime unavailable |
| C | AgentHub/MCP routing | worker contracts, adapter inventory, ledger correctness, blocker taxonomy | `MCP_TOOL_CONTRACT_MISSING`, `AGENTHUB_LIVE_WORKER_ROUTE_MISSING` | T0 cannot mutate runtime directly |
| D | Live runtime / Docker / DB / proxy | real service repair and validation | `LIVE_ADAPTER_ENABLEMENT_REQUIRED`, `DEVOPS_WORKER_AUTH_MISSING`, `OWNER_ONLY_DESTRUCTIVE_GATE` | repo/register work available |
| E | Browser / user outcome QA | browser validation and final user path proof | `BROWSER_WORKER_ROUTE_MISSING`, `TARGET_SERVICE_UNAVAILABLE` | repo or task graph work available |
| F | User communication | short Russian final output | none | missing evidence in another lane |

## Propagation Rule

A blocker stops only the lane where the missing capability is required. It may
become global only when evidence proves that every remaining lane depends on the
same missing route. Absence of a live runtime adapter blocks lane D, not lanes
A, B, C, or F.

## Same-Gate Loop Limit

For the same `scope_signature`, if the same gate fails twice with the same
missing route and no new evidence, a third equivalent attempt is forbidden.
The next action is `BLOCKER_COLLAPSE_LOOP` plus a repo/task architecture repair.

## Evidence Classes

Important claims must be classified as one of:

- `VERIFIED_BY_REPO`
- `VERIFIED_BY_YOUTRACK`
- `VERIFIED_BY_AGENTHUB_LEDGER`
- `VERIFIED_BY_RUNTIME_WORKER`
- `USER_REPORTED_NOT_VERIFIED`
- `HYPOTHESIS`
- `CONTRADICTED`

User anger, prior agent text, sandbox receipts, PR existence, and generic PASS
logs are incident inputs, not proof of implementation.

## Final State Rule

Allowed final states are:

- `DONE_WITH_EVIDENCE`
- `READY_BLOCKED_BY_PLATFORM_GATE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `FORBIDDEN_SCOPE_BLOCKER`
- `SAFETY_QUARANTINE`

Generic `blocked` is invalid. Each blocker must include lane, exact missing
capability, evidence pointer, and next legal route.

## Safety Rule

T0 must not mutate runtime, Docker, DB, proxy, firewall, ports, services,
secrets, or product code. Runtime lane D requires a scoped authorized worker
with read-before-write, rollback/checkpoint, and validation.
