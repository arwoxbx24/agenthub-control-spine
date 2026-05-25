---
name: agenthub-permission-gate-router
description: Route AgentHub tasks through scoped permission classes P0-P9, split false global blockers from valid local safety gates, and prevent permissive runtime bypass.
---

# AgentHub Permission Gate Router

Use when a task asks for access, permissions, live worker enablement, or blocker
triage across repo, YouTrack, MCP, evidence transport, browser, or runtime.

## Steps

1. Identify task id, RUN_ID, lane, and affected service.
2. Select the minimum permission class from P0-P9.
3. Verify allowed role and required evidence.
4. Block T0 from P4-P8 runtime mutation.
5. Convert missing capability to an exact typed blocker.
6. Keep unrelated lanes moving.

## Deny Rules

- No wildcard shell/Docker/DB/proxy authority.
- No P5-P8 without scoped worker receipt.
- No secret/account gate bypass.
- No parent Done while child implementation task remains open.

## Output

Return permission class, owner, evidence, fallback route, blocker, and whether
the blocker is local or global.
