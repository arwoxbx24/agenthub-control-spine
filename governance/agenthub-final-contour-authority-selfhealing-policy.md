---
artifact_id: agenthub-final-contour-authority-selfhealing-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker / Authority Broker / Registrar / Verifier
source_task: AH-769
run_id: RUN-AGENTHUB-FINAL-CONTOUR-AUTHORITY-SELFHEALING-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Final Contour Authority Self-Healing Policy

This policy converts routine in-contour blockers into same-RUN PackFix work instead of final chat blockers.

## Contour contract

Every active contour must bind:

- one controlling YouTrack task or bounded parent/child graph;
- one RUN_ID;
- one project/service scope descriptor;
- one authority decision trail;
- one Kanban stage trail;
- one GitHub evidence trail when repository artifacts exist;
- one final closure state.

## Authority principle

Do not remove all restrictions. Grant maximum scoped authority inside the active contour and zero authority outside it.

Owner-only gates are limited to secrets/account/payment/legal authority, forbidden scope, destructive DB or Docker volume actions, broad infrastructure rewrites, and irreversible data/service deletion without backup/replacement proof.

## Routine blocker inversion

These blockers must become same-RUN PackFix when they are inside active contour and routine-repairable:

- `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`
- `RUNTIME_TOOL_INSTALLATION_REQUIRED`
- `LIVE_WORKER_AUTHORITY_MISSING_AFTER_PACKFIX`
- `VALIDATOR_EXECUTION_NOT_RUN`
- `REGISTER_APPEND_ROUTE_PENDING`
- `PR_QUEUE_UPDATE_PENDING`
- `INDEX_REGISTER_UPDATE_PENDING`
- `YOUTRACK_READBACK_PERMISSION_MISSING`
- `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`
- `MODEL_FALLBACK_RECEIPT_MISSING`
- `PUBLIC_ROUTE_FAILURE` when route repair is in scope
- `UI_BACKEND_BROWSER_USER_PROOF_MISSING` when browser QA route can be installed

## Required lanes

- Lane 0: docs, intake, planning.
- Lane 1: repository artifact work.
- Lane 2: YouTrack/Kanban work.
- Lane 3: validator execution.
- Lane 4: runtime read and microservice inventory.
- Lane 5: browser/user outcome QA.
- Lane 6: scoped live repair with rollback and canary.
- Lane 7: destructive/irreversible action, owner-only unless exact destructive authority exists.

## Kanban hardlock

A new task may stay in Backlog only during intake. Work moves the task to Develop. Validation moves it to Review/Preview and Test. Done requires evidence, validation, receipt, no-blocker marker, GitHub linkage when applicable, and final readback.

No created task may be abandoned in Backlog. Duplicate tasks must be linked/closed or absorbed in the same RUN.

## Evidence labels

Evidence must be labeled as route metadata, sandbox only, backend only, HTTP only, browser rendered, user-flow validated, validator executed, live read confirmed, live repair confirmed, model execution proven, or GitHub-YouTrack binding confirmed.

Done is forbidden if evidence quality is weaker than the task requires.

## Final states

Allowed final states only:

- `DONE_WITH_EVIDENCE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `FORBIDDEN_SCOPE_OUTSIDE_CONTOUR`
- `SECURITY_QUARANTINE_SECRET_RISK`

`READY_BLOCKED_BY_PLATFORM_GATE` is forbidden when the gate is routine and in scope.
