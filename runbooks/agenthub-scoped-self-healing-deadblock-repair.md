---
artifact_id: agenthub-scoped-self-healing-deadblock-repair-20260611
artifact_type: runbook
source_task: AH-745
run_id: RUN-AGENTHUB-BLOCKER-INVERSION-SCOPED-SELF-HEALING-20260611
status: active
---

# AgentHub Scoped Self-Healing Deadblock Repair

1. Bind to the existing YouTrack issue and RUN.
2. Classify blocker by lane 0-6.
3. If routine, execute repair recipe in the same contour and retry once.
4. If permission-bound, request exact broker elevation with tool, operation, resource scope, forbidden scope, validation, and receipt.
5. If task lifecycle-bound, move issue to the correct stage and read back.
6. If prompt dump, suppress dump and execute the prompt as contract.
7. If model truth, require usage/audit/client/API proof; env route labels do not pass.
8. If Lane 6, require replacement, backup, or explicit owner abandon/delete proof.
9. Stop only on allowed terminal blocker.
10. Final only after YouTrack Done readback and receipt.
