---
artifact_id: root-changelog
artifact_type: changelog
owner_role: T1 Architecture Broker
source_task: AH-494
created_at: 2026-05-22
supersedes: none
status: draft
---

# Changelog

## 2026-05-24

- Added NPM gap closure report and receipt for `n8.b244.ru`, `dash.b244.ru`, and blocked `claw.b244.ru` follow-up without duplicating completed AH-513/AH-518 work.
- Added AH-521 deferred no-start report and receipt for `claw.b244.ru` backend, preserving `CLAW_BACKEND_SERVICE_MISSING` without starting the service.
- Closed AH-521 administratively as deferred by user instruction to prevent duplicate agent tasks while preserving that the backend was not started.

## 2026-05-23

- Added AH-513/AH-518 NPM Docker addressing worker report and receipt with partial implementation evidence and remaining blocker.
- Added MTProxy domain route worker report and operational receipt for the accepted TimeWeb direct TCP endpoint.
- Added AH-511 agent-cycle self-critique postmortem.
- Added draft skills for T0 non-authoring, DevOps incident diagnostics, and AgentHub evidence loop closure.
- Strengthened the T0/T1/Worker role matrix with a hard invalidation rule for direct T0 mutation.
- Indexed AH-511 report and skills in `INDEX.md`.

## 2026-05-22

- Created initial AgentHub Control Spine repository scaffold.
- Added governance docs, schemas, runbooks, and artifact index.
- Added current ChatGPT Project handoff report and index entry.
- Added GitHub secret-defense policy, response runbook, scanner templates, hooks, workflow, schema, redacted org scan summary, and rollout receipt.
- Added AH-501 current-content secret exclusion summary and receipt.
- Marked AH-501 secret exclusion complete after `browser-logger-extension` PR #1 merge and clean redacted rescan.
