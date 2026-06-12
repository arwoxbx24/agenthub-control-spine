---
artifact_id: agenthub-kanban-board-stage-governor-runbook
artifact_type: runbook
owner_role: T0 Registrar / Task Worker
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Kanban Board Stage Governor

1. Search duplicates by normalized signature.
2. Create or select exactly one controlling task.
3. Move Backlog to Develop before work starts.
4. Move Develop to Preview after artifact/PR/sandbox evidence exists.
5. Move Preview to Test after validators are ready.
6. Move Test to Done only after final evidence, validation, receipt, no-blocker marker, and readback.
7. If readback fails, create same-RUN PackFix and retry once.
