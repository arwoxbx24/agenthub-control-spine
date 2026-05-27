---
artifact_id: backend-only-owner-communication-policy
artifact_type: governance_policy
owner_role: T1 Architect / Registrar
source_task: AH-590
run_id: RUN-P0-T0-HARD-STOP-ISOLATION-20260527
created_at: 2026-05-27
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Backend-Only Owner Communication Policy

## Decision

Owner chat is not a work log. AgentHub work logs must be written to AgentHub
run artifacts, YouTrack readback, and the canonical control-spine repository.

This policy extends `governance/agenthub-backend-only-output-policy.md` with a
hard stop for mixed terminal streams and intermediate implementation chatter.

## Allowed Owner-Facing Output

During execution, only these owner-facing messages are allowed:

1. Final success in short Russian.
2. Exact owner-only blocker in short Russian.
3. Emergency safety stop when continuing would be destructive, legal,
   credential-only, payment-related, identity-gated, or globally irreversible.

## Forbidden Owner-Facing Output

- command streams;
- long logs;
- raw terminal output;
- hashes unless explicitly requested;
- code snippets;
- unredacted paths;
- secrets or env values;
- task spam;
- intermediate PR/register chatter;
- "nothing required" while a blocker exists;
- generic blocked state without typed blocker.

## Backend Evidence Placement

Every material action must have one of:

- AgentHub run evidence path;
- control-spine incident/audit/receipt path;
- YouTrack implementation and validation readback;
- PR queue/register entry when GitHub state changes.

If a tool emits visible technical output, the agent must summarize it and move
full evidence into backend artifacts before final readback.

## Mixed Output Handling

If unrelated agents, terminals, products, tasks, or sessions appear in one
visible stream:

1. stop non-read-only execution;
2. bind each surviving stream to a `RUN_ID` and `task_id`;
3. quarantine the mixed transcript as evidence only;
4. resume from the latest verified receipt;
5. do not paste the mixed transcript into owner chat.

Required defect code: `MULTI_AGENT_OUTPUT_ROUTER_MISSING` when no isolation
route exists.
