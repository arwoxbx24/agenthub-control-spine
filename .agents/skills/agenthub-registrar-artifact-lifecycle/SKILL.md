---
name: agenthub-registrar-artifact-lifecycle
description: Enforce control-spine artifact lifecycle, default_load, safe_to_replay, register coverage, and prompt quarantine.
---

# AgentHub Registrar Artifact Lifecycle

Use when adding or changing control-spine artifacts.

Required:

1. Read `INDEX.md`, `ARTIFACT_REGISTER.md`, and `PR_QUEUE_REGISTER.md`.
2. Register every new artifact with lifecycle, default_load, safe_to_replay,
   owner_role, source_task, and run_id.
3. Default reports, receipts, prompts, handoffs, and research to
   `default_load=false` and `safe_to_replay=false`.
4. Mark one-time prompts `consumed_prompt` after execution.
5. Quarantine stale or conflicting artifacts.
6. Write a receipt for non-trivial control changes.
