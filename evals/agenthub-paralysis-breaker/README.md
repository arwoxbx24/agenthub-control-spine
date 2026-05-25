---
artifact_id: agenthub-paralysis-breaker-evals
artifact_type: eval-fixtures
owner_role: Verifier
source_task: AH-542
run_id: RUN-agenthub-p0-paralysis-breaker-repo-first-control-repair-20260525
created_at: 2026-05-25
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Paralysis Breaker Evals

These fixtures cover the minimum regression cases for AH-542:

- same blocker twice triggers architecture repair, not a third retry;
- sandbox proof cannot close production/user Done;
- live adapter absence blocks only lane D;
- duplicate task creation is blocked;
- parent Done is blocked with open implementation children;
- prompts/reports default-load false unless registered as active controls;
- user final output stays short Russian Caveman.
