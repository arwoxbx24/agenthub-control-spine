---
name: t0-non-authoring-gate
description: Prevent Team Lead T0 from authoring product code, runtime changes, service mutations, or repo implementation patches unless the task is explicitly governance-only or a fallback worker receipt is registered before mutation.
owner_role: T0 Control Plane
source_task: AH-511
status: draft
---

# T0 Non-Authoring Gate

## Purpose

Enforce the core methodology: T0 routes, decomposes, verifies, merges, and reports. T0 does not implement product/runtime changes.

## Trigger Conditions

Use this skill before any action that could change:

- product code;
- runtime behavior;
- Docker, systemd, proxy, firewall, database, queue, secret, or deployment state;
- tests or validation state;
- generated app artifacts;
- repository implementation files outside governance/policy/report/skill drafts.

## Allowed T0 Actions

- intake and classification;
- duplicate check;
- task creation or update;
- AgentHub run creation;
- worker dispatch;
- read-only context gathering;
- merge and validation review;
- final user report;
- governance-only edits when the current task explicitly targets governance/policy/report/skill files and AgentHub route has been attempted.

## Forbidden T0 Actions

- editing product/runtime code directly;
- running service mutation commands directly;
- repairing Docker/systemd/proxy/database state directly;
- creating hidden fallback evidence after mutation and calling it normal;
- marking Done from runtime health alone;
- treating user urgency as permission to bypass worker ownership.

## Required Gate

Before mutation, exactly one must be true:

1. `governance_only_scope=true` and changed files are limited to governance, reports, schemas, runbooks, or skill drafts.
2. `worker_ownership_receipt=PASS` with worker id, task id, owned files/actions, allowed scope, forbidden zones, and validation contract.
3. `fallback_worker_receipt=PASS` registered before mutation, with reason normal worker dispatch is unavailable and the exact mutation class allowed.

If none is true, return:

```text
BLOCKED_T0_DIRECT_AUTHORSHIP
```

## Evidence Required

- route receipt;
- task id;
- worker or fallback worker id;
- owned surface;
- forbidden-zone confirmation;
- validation evidence;
- merge evidence.

## Negative Test

If T0 patches a Docker compose file, restarts a service, edits application code, or changes tests without a worker/fallback-worker receipt first, the run is invalid even if the final service check is green.

## Done Condition

`PASS` only when mutation ownership is non-T0 or the task is explicitly governance-only.
