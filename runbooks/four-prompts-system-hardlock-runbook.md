---
artifact_id: four-prompts-system-hardlock-runbook
artifact_type: runbook
owner_role: T1 Architect / T2 Governance Worker / Verifier
source_task: RUN-20260615-FOUR-PROMPTS-SYSTEM-ARCH
run_id: RUN-20260615-FOUR-PROMPTS-SYSTEM-ARCH
created_at: 2026-06-15
lifecycle_status: active_runbook
default_load: false
safe_to_replay: false
---

# Four Prompts System Hardlock Runbook

## 1. Start

Bind a task, RUN, role, branch, allowed scope, forbidden surfaces, validation
contract, and receipt path. If the task service cannot physically create or read
the task, record `TASK_SERVICE_PHYSICAL_WRITE_STILL_FAILS` and continue only for
repository-local governance artifacts. Do not claim full Done without readback.

## 2. Classify Environment

Classify every target as `LOCAL_ONLY`, `TEST_SERVER`, `STAGING`, `PRODUCTION`,
`PROD_RISK_UNKNOWN`, `ARCHIVED_REMOTE`, `READ_ONLY_REMOTE`, or
`WORKFLOW_SIDE_EFFECT_UNKNOWN`.

`main`, `master`, unknown workflow effects, deploy workflows, public/client
domains, and unknown remotes are blocked for test work until proof exists.

## 3. Prove Test-Only Route

Before test work, collect machine-readable proof that the route updates only the
test target, the branch/ref is fetchable by the test server, workflow impact
excludes production, and no product `main`/`master` merge is required.

Missing proof becomes same-RUN PackFix. Do not use `main`/`master` fallback.

## 4. Audit Workflow Impact

Before workflow run/watch/dispatch or merge-dependent automation, inspect the
workflow file, triggers, environments, deploy jobs, secrets/env names, branch
conditions, remote targets, reusable workflows, protected reviewers, and branch
protection side effects.

Production or unknown effect is blocked unless exact scoped owner phrase exists.

## 5. Production Release Phrase

Accept only: `разрешаю отгрузку на прод`.

It authorizes only the described release after test proof and rollback plan. It
does not authorize future production actions, DB/proxy/runtime changes, broad
restart, or feature fixes on production.

## 6. Owner Distress

If the owner reports site/client impact, switch to incident mode. Do not answer
with apology loops or stop-only chat. Start read-only triage, classify blast
radius, build last-known-change ledger, choose safe recovery, and validate user
outcome.

Owner-facing crisis output is limited to:

```text
Fact: <one-line state>
Action: <one-line current safe action>
Left: <none or exact owner-only irreversible blocker>
```

## 7. Safe Rollback

Rollback requires last-known-good evidence, pre-registered reversible lane,
checkpoint, scoped worker route, and validation. If rollback touches forbidden
surfaces or is irreversible, stop with `OWNER_ONLY_IRREVERSIBLE_GATE`.

Feature fixes on production are blocked.

## 8. PR171/Gitleaks Closure

For PR171/AH-794 style tasks, verify gitleaks/security gate, merge gate, PR
state, branch state, task readback, register coverage, and no open same-scope
tail. Platform blockage is `PLATFORM_BRANCH_PROTECTION_GATE`, not fake Done.

## 9. Done

Done requires implementation evidence, validation evidence, receipt, task
readback, register coverage, no blocker, no forbidden surface, and no same-scope
open tail. If task-service readback is unavailable, repository-local package can
be installed but final state remains typed-blocked.

