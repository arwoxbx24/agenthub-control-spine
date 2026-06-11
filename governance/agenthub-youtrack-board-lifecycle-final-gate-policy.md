---
artifact_id: agenthub-youtrack-board-lifecycle-final-gate-policy-20260611
artifact_type: governance_policy
source_task: AH-745
run_id: RUN-AGENTHUB-BLOCKER-INVERSION-SCOPED-SELF-HEALING-20260611
status: active
---

# AgentHub YouTrack Board Lifecycle Final Gate Policy

## Purpose

Implementation contours close only when the controlling YouTrack issue reaches `Done` with readback and evidence. GitHub merge, task creation, prompt text, receipt-only output, or sandbox proof is not task completion.

## Required Movement

- Backlog/Todo -> Develop before implementation.
- Develop -> Review after artifacts are installed.
- Review -> Test after verifier handoff.
- Test -> Done after validation passes and evidence/receipt are linked.

## Final Done Gate

Final success requires issue id, duplicate check, board visibility, stage movement attempt, final `Done` readback, Done gate PASS, evidence/validation links, parent/child closure validity, and no duplicate orphan tasks.
