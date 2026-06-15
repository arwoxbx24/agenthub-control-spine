---
artifact_id: scoped-test-runtime-browser-worker-packfix-policy
artifact_type: governance-policy
source_task: AH-793
run_id: scoped-test-runtime-browser-packfix-20260615
status: active_control_candidate
safe_to_replay: false
---

# Scoped Test Runtime Browser Worker PackFix Policy

## Purpose

Turn routine runtime, command-worker, and browser-worker blockers for test-only user-visible work into same-RUN PackFix remediation instead of owner-facing blocker chatter.

## Test URL Hardlock

AH-793 visible-outcome work is allowed only on:

`https://stroy-test.b244.ru/a/?p=banners`

Any production, working-site, `master`/`main` product branch, or unknown environment route is blocked.

## Routine Blocker Handling

When `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`, `T0_DIRECT_RUNTIME_MUTATION_DEFECT`, missing browser worker, or missing command worker appears:

1. Record the blocker internally.
2. Create same-RUN PackFix `CONTRACT_ONLY_TO_SCOPED_TEST_WORKER_ROUTE` or `T0_TO_T2_SCOPED_TEST_WORKER_ROUTE`.
3. Request lane `L7_AGENTHUB_BROWSER_WORKER` or `L6_AGENTHUB_COMMAND_WORKER` with exact task, run, URL, branch or PR, allowed action, forbidden surfaces, expiry, rollback, and receipt.
4. Continue through approved route only.

Do not send owner-facing `blocked`, `not closed`, `need worker`, or shell-handoff text for routine blockers.

## Client Visible Result Gate

Closure requires browser/user outcome proof on the test URL:

- valid test banner is added and visible, followed by cleanup evidence; or
- a specific `AH793-*` page error is captured and converted into the next same-RUN code PackFix.

CI green, PR open, code ready, internal AgentHub DONE, or screenshot-only backend claims cannot close the task.

## Forbidden Surfaces

No production URL, working site, product `main`/`master`, production workflow, DB, Docker, Nginx, proxy, firewall, PM2, DNS, SSL, direct shell bypass, secret mutation, or fake Done.
