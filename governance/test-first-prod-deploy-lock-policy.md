---
artifact_id: test-first-prod-deploy-lock-policy
artifact_type: governance-policy
source_task: AH-794
run_id: AH-PROD-LOCK-TEST-FIRST-GOVERNANCE-20260614
status: active_control
created_at: 2026-06-14
safe_to_replay: false
---

# Test-First Production Deploy Lock Policy

## Purpose

Prevent a test-only task from crossing into production through GitHub branch, workflow, deployment, or release actions.

## Hard Invariant

A task classified as test-only cannot merge, push, dispatch, deploy, restart, publish, sync, upload, invalidate cache, or mutate any production route.

Production release is allowed only when both are present for the exact release:

1. Test contour evidence is complete: route proof, test execution, browser/user outcome, owner acceptance when required, and release candidate receipt.
2. Owner gives the exact phrase: `разрешаю отгрузку на прод`.

No synonym authorizes production. Urgency words, workflow success, PR merge success, or rollback success are not production approval.

## Environment Classification

Every action is classified before execution:

- `LOCAL_ONLY`
- `TEST`
- `STAGING`
- `PRODUCTION`
- `UNKNOWN_PROD_RISK`

`UNKNOWN_PROD_RISK` is treated as `PRODUCTION` and blocked.

## Production-Risk Defaults

The following are production-risk by default:

- merge or push to `master` or `main` in a client/product repository;
- workflow run on `master` or `main`;
- any workflow/job that can deploy, restart, sync, publish, upload, invalidate cache, or touch production;
- production environment job;
- production secrets or environment secrets;
- SSH, FTP/SFTP, rsync, deploy keys, server runner, PM2, Docker, proxy/NPM, DB, DNS, SSL, firewall, object storage, CDN, or public production URL mutation;
- any route where environment impact is unknown.

## Test-Only Route Proof

Before any action in a test task, create a route proof with:

- target repository;
- target branch;
- target environment;
- workflow id/name/path;
- trigger event;
- secrets/environment used;
- deployment target;
- public URL affected;
- branch filters;
- whether a production workflow can be triggered;
- whether production secrets can be accessed;
- conclusion: `TEST_ONLY_PASS`, `PROD_RISK_BLOCKED`, or `UNKNOWN_IS_PROD_RISK`.

Missing proof blocks execution.

## Workflow Impact Audit

Before PR, merge, workflow run, or deployment-related action:

1. Read workflow YAML.
2. Read triggers and branch filters.
3. Read environment declarations.
4. Read secrets/environment references.
5. Read repository default branch and current branch.
6. Determine whether the action can trigger production.
7. Write a workflow impact receipt.

Workflow names are not evidence. YAML, branch/default-branch facts, environment declarations, secrets references, and run history are evidence.

## Owner Test Confirmation Gate

User-visible work requires at least one accepted test proof before release or delivery claim:

- browser-worker trace/screenshot/video on the test environment;
- owner screenshot/video/text confirmation from the test environment;
- recorded test session evidence;
- explicit owner acceptance text for the exact test checklist.

Owner confirmation requests must include exact test URL, role/account type, one to three actions, expected result, acceptable proof, and a statement that the action is test-only.

## Delivery Claim Gate

Do not write client-ready delivery text unless the claim ledger contains only green claims backed by direct evidence.

## Enforcement

The validator `validators/test_first_prod_deploy_lock_validator.rb` is the deterministic release gate. A route blocked by this policy must stop with a typed blocker, not retry blindly and not reclassify by workflow title.