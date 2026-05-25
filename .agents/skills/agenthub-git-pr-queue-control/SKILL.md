---
name: agenthub-git-pr-queue-control
description: Prevent duplicate control-spine PRs, stale PR loops, unmanaged open PRs, and PR-only Done claims.
---

# AgentHub Git PR Queue Control

Use for control-spine branch, commit, PR, merge, close, and queue state work.

Rules:

1. Search open PRs for the same `source_task`, `scope_signature`, branch, and
   artifact set before opening a new PR.
2. Use one branch and one PR for one scope unless a registrar explicitly splits
   lanes.
3. Every open PR needs queue class, owner role, next action, evidence pointer,
   blocker, source task, and RUN_ID in `PR_QUEUE_REGISTER.md`.
4. A PR or commit alone is not YouTrack Done.
5. Close stale PRs only through Registrar authority with evidence preserved.
