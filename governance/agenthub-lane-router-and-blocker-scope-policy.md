---
artifact_id: agenthub-lane-router-and-blocker-scope-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker
source_task: AH-738 / PR152 follow-up
run_id: RUN-AGENTHUB-SMART-SELF-HEALING-AUTHORITY-ELEVATION-20260611
created_at: 2026-06-11
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
supersedes: AGENTHUB-SCOPED-AUTONOMY-AUTHORITY-SELF-HEALING-ESCALATION-CONTRACT-20260610
---

# AgentHub Lane Router And Blocker Scope Policy

## Purpose

This policy converts routine AgentHub deadblocks into same-RUN self-healing.
It preserves hard stops for secrets, destructive actions, and global
infrastructure while allowing bounded autonomy inside the active contour.

## Lanes

| Lane | Name | Authorized roles | Allowed core actions | Hard stop examples |
|---|---|---|---|---|
| 0 | owner communication | T0, T1 | short Russian `Fact / Action / Left`, duplicate-progress suppression | none |
| 1 | control-spine artifacts | T0 Registrar, T1 Architect, scoped repo writer | prompts, governance, validators, schemas, fixtures, receipts, register/index edits | runtime mutation, personal repo use |
| 2 | repository hygiene | Registrar, git hygiene worker | merged-branch delete, closed-stale branch delete, PR tail cleanup, queue/register updates | protected branch delete, broad cleanup |
| 3 | task/run self-healing | T0 Router, T1 Architect, task-service repair worker | create/link task, bind RUN_ID, repair route/task receipts, fallback receipt on task-service access failure | endless task creation, fake readback |
| 4 | read-only live diagnostics | T2 read-only worker, Verifier | service status, container list, redacted logs, HTTP health, process readback | restart, delete, exec mutation, DB read without scope |
| 5 | reversible runtime repair | T2 repair worker | named restart, narrow config fix, rollback to known-good target, restore from backup | broad prune/reset/delete, DB destructive mutation |
| 6 | destructive cleanup | T2 destructive worker, Verifier, owner or pre-approved authority | delete only with exact proof, replacement or backup evidence, receipt | production destructive delete without proof |

## Self-Healing Rule

First occurrence of a routine blocker must trigger one same-RUN repair action.
Only the second failed repair may produce a typed terminal blocker.
Routine blockers must not become owner-facing stops on first occurrence.

## Conversion Table

| Blocker | Required same-RUN action | Terminal only after |
|---|---|---|
| `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID` | locate or create controlling task, bind RUN_ID, retry once | task-service and repo fallback both unavailable |
| `DISPATCH_TASK_GATE_MISSING` | create route receipt from active task/RUN/branch, retry once | second route repair failure |
| `T0_DIRECT_AUTHORSHIP_DEFECT` | reclassify Lane 1 artifact work to scoped repo writer or registrar route | no writer route exists |
| `MODEL_FALLBACK_RECEIPT_MISSING` | auto-write same-RUN fallback receipt and continue | no approved model route exists |
| `DUPLICATE_PROGRESS_OUTPUT_BLOCKED` | suppress duplicate progress and continue | repeated suppression still emits duplicate spam |
| `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` | elevate to Lane 4 read-only worker or Lane 5 reversible worker | no approved worker route after two distinct repairs |
| `FRESH_BRANCH_PROTECTED` | classify lifecycle and allow delete only for merged, closed-stale, or audit-only branch with SHA pin and open-PR check | lifecycle proof missing |
| task-service `missing-access` | write repo fallback receipt and open one route-repair task if possible | both task-service and repo receipt unavailable |

## Same-Gate Loop Limit

For one `scope_signature`, two failed repairs are the maximum. A third equivalent
attempt is forbidden. The run must emit one typed terminal blocker with the last
repair receipt reference.

## Final States

Allowed final states are:

- `DONE_WITH_EVIDENCE`
- `READY_BLOCKED_BY_PLATFORM_GATE`
- `OWNER_ONLY_DESTRUCTIVE_CONFIRMATION_REQUIRED`
- `NO_APPROVED_WORKER_ROUTE_AFTER_REPAIR`
- `TASK_SERVICE_AND_REPO_RECEIPT_BOTH_UNAVAILABLE`
- `LANE6_PROOF_MISSING`
- `SECRET_EXPOSURE_RISK`
- `GLOBAL_INFRASTRUCTURE_AUTHORITY_MISSING`
- `DUPLICATE_SCOPE_PR_EXISTS`

Generic `BLOCKED` is forbidden.

## Safety Boundaries

- T0 must not become an unbounded runtime mutator.
- Lane 4 is read-only and is not Lane 5 repair.
- Lane 5 reversible repair is not Lane 6 destructive cleanup.
- Docker prune/reset/delete, DB destructive mutation, proxy/firewall/DNS/SSL
  mutation, and raw secret output remain hard stops unless the exact scoped lane
  proof exists.
