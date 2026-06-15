---
artifact_id: four-prompt-architecture-hardlock-runbook
artifact_type: runbook
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-796
run_id: four-prompt-architecture-hardlock-20260615
created_at: 2026-06-15
lifecycle_status: active_runbook
default_load: false
safe_to_replay: false
---

# Four Prompt Architecture Hardlock Runbook

Closed-contour execution flow:

1. Capture the owner request and the four source prompts.
2. Classify the prompts as primary, supplement, supplement, and point-fix.
3. Bind one YouTrack task and one RUN id.
4. Route one scoped AgentHub worker with explicit model.
5. Prove environment and route before mutation.
6. Audit workflow impact before any workflow-dependent claim.
7. Act only in control-spine governance scope.
8. Validate with deterministic fixtures.
9. Write receipt and truth ledger.
10. Register package in `INDEX.md`, `ARTIFACT_REGISTER.md`, and
    `PR_QUEUE_REGISTER.md`.
11. Open/update one PR only when the route allows it.
12. Merge only if branch protection passes.
13. Read back main and YouTrack before Done.

If task, PR, or merge route is unavailable, produce one typed blocker and stop.
Do not ask the owner to run shell commands. Do not retry the same blocked command
more than once per evidence state.

