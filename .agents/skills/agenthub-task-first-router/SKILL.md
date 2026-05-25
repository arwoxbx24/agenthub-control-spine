---
name: agenthub-task-first-router
description: Find or create one controlling YouTrack task, dedupe duplicates, and prevent task explosion before AgentHub execution.
---

# AgentHub Task-First Router

Use for AgentHub work that can create, update, close, or validate tasks.

Steps:

1. Normalize `scope_signature`.
2. Search YouTrack for duplicate open and recent closed tasks.
3. Reuse the existing controlling task when present.
4. Create exactly one new task only when no matching task exists.
5. Link duplicates and record Duplicate, Superseded, Blocked, or Tracking state.
6. Block Done without task readback, implementation evidence, validation
   evidence, route receipt, and no active blocker.

Never treat task creation as implementation progress.
