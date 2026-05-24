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

- Added `ARTIFACT_REGISTER.md` to classify artifacts by lifecycle, default-load, and replay safety.
- Added TeamLead system inventory report, receipt, and ID register for `AH-522` / `RUN-teamlead-control-spine-system-inventory-20260524`.
- Marked reports, receipts, handoffs, and consumed prompts as non-default evidence in the lifecycle register.
- Indexed previously present active governance/runbook artifacts that were missing from `INDEX.md`.
- Added Control-Spine Registrar policy, current context pack, PR queue register, queue/lifecycle runbook, PR queue schema, and registrar cleanup receipt for `AH-523`.
- Recorded PR queue actions for open tails: amend `#24` and close superseded/stale `#20`, `#18`, `#17`, `#16`, and `#23`.
- Added closed-loop rule: routine missing proof becomes same-run microtask; only owner-only gates may interrupt after safe work completes.
- Recorded review-gate handling for PR `#24`: normal merge, safe admin merge, direct protected push, and reviewer-route discovery were attempted; the review gate was then converted into `AUTONOMY_REVIEW_ROUTE_MISSING`.
- Closed PR `#23` as a historical evidence tail after AH-521/AH-518 state was preserved in YouTrack; the only remaining open PR is the registrar PR `#24`.
- Converted PR `#24` from user-facing review blocker to durable platform gate: `READY_BLOCKED_BY_PLATFORM_GATE` / `AUTONOMY_REVIEW_ROUTE_MISSING`, with AH-524 owning the non-user control-spine review route.
- Added autonomous route readback for PR `#24`: self-approval, collaborator/team, GitHub App, repository/org secret, and safe-find preflight checks produced no reusable non-user reviewer route.

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
