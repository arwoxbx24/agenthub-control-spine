---
artifact_id: four-prompts-system-hardlock-policy
artifact_type: governance-policy
owner_role: T1 Architect / T2 Governance Worker / Registrar / Verifier
source_task: RUN-20260615-FOUR-PROMPTS-SYSTEM-ARCH
run_id: RUN-20260615-FOUR-PROMPTS-SYSTEM-ARCH
created_at: 2026-06-15
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
supersedes: owner-distress-prod-recovery-control-policy where broader test/prod workflow gates apply
superseded_by: none
---

# Four Prompts System Hardlock Policy

## Purpose

This policy converts the four prompt-architect source prompts into one
deterministic AgentHub control-spine gate. The prompts are not reusable chat
answers and are not quick indexes. They are release-blocking architecture
requirements for test/prod separation, owner-distress incident routing,
safe rollback, terminal PR/gitleaks closure, and evidence-backed Done.

The source prompts are applied in this order:

1. `AGENTHUB-PERMANENT-PROD-INCIDENT-RECOVERY-AND-TEST-FIRST-HARDLOCK-PROMPT`
2. `AGENTHUB-PERMANENT-TEST-FIRST-PROD-DEPLOY-LOCK-GOVERNANCE-PROMPT`
3. `AGENTHUB-PERMANENT-OWNER-DISTRESS-PROD-RECOVERY-CONTROL-PROMPT`
4. `AGENTHUB-PR171-GITLEAKS-MERGE-GATE-TERMINAL-CLOSURE-PROMPT`

The first prompt is the primary system state machine. The second and third are
coverage supplements. The fourth is a point-fix closure gate for PR171/AH-794
style security and merge terminal states.

This policy is governance-only. It does not authorize product code mutation,
production or test site mutation, workflow dispatch, GitHub merge, server write,
database access, proxy changes, firewall changes, process-manager changes,
secrets, DNS, SSL, Railway, object storage, or destructive cleanup.

## Task Binding Gate

Before any action that can mutate a repository, workflow, deploy surface,
runtime state, task state, or closure state, the worker must prove:

- exact task id or typed task-service blocker;
- exact `RUN_ID`;
- scope signature;
- allowed repository and branch;
- forbidden surfaces;
- assigned role and worker model;
- validation contract;
- receipt path.

If any item is missing, the terminal state is `TASK_BINDING_MISSING`, not Done.

## Environment State Machine

Every target must be classified before action:

- `LOCAL_ONLY`
- `TEST_SERVER`
- `STAGING`
- `PRODUCTION`
- `PROD_RISK_UNKNOWN`
- `ARCHIVED_REMOTE`
- `READ_ONLY_REMOTE`
- `WORKFLOW_SIDE_EFFECT_UNKNOWN`

Rules:

- Product `main` or `master` is `PROD_RISK_UNKNOWN` until a machine-readable
  release gate proves otherwise.
- A workflow name containing "test" is never proof of test-only scope.
- A branch name containing "test" is never proof of test-only scope.
- An `origin` remote name is never proof of target environment.
- Unknown workflow effects, deploy jobs, public/client domains, protected
  environment ambiguity, or unknown branch effects are `PROD_RISK_UNKNOWN`.
- `ARCHIVED_REMOTE` and `READ_ONLY_REMOTE` cannot be silently bypassed through a
  second remote; they require PackFix route discovery.

## Test-Only Proof Gate

Feature, test, or user-visible validation work may proceed only when the
`test_only_route_proof` proves all of:

- approved test URL or approved test server;
- deploy/fetch route updates only test;
- workflow impact audit excludes production environments, deployments, jobs,
  secrets, and reusable workflows;
- branch/ref is test-only and fetchable by the test server;
- no product `main`/`master` merge is required for test delivery;
- production domain is not accessed except read-only incident health checks
  during an active incident.

Missing proof becomes `TEST_ONLY_ROUTE_PROOF_MISSING` and must be converted into
same-RUN PackFix. Workers must not use product `main`/`master` as fallback.

## Workflow Impact Audit Gate

Before running, watching, dispatching, or relying on a workflow, and before
merging a PR that can trigger deploy automation, the worker must audit:

- workflow file path and trigger set;
- target environments and deployment jobs;
- secret/env names and reusable workflows;
- branch/ref conditions;
- remote targets;
- protected environment reviewers;
- branch protection effects.

If effect can touch production or remains unknown, the terminal state is
`WORKFLOW_IMPACT_AUDIT_MISSING` or `PROD_RELEASE_AUTHORIZATION_MISSING`.

The only accepted production release phrase is exact and action-scoped:
`разрешаю отгрузку на прод`. It authorizes only the described release.

## Owner-Distress Incident Gate

Owner distress phrases are incident triggers, not ordinary chat:

- "site broken"
- "client screaming"
- "production broken"
- "you destroyed the site"
- "panic"
- "karau" / "караул"
- "сайт сломан"
- "прод сломан"
- "рабочий сайт сломан"
- "ты сломал сайт"
- "восстанови сайт"
- equivalent service-impact complaint.

On trigger, the worker must:

1. stop unsafe mutation;
2. bind or create a P0 incident task/RUN, or record task-service blocker;
3. start read-only state capture through authorized route;
4. classify blast radius and environment;
5. build last-known-change ledger;
6. choose safe recovery option;
7. use only a pre-approved reversible rollback lane when all rollback gates pass;
8. validate browser/user outcome after recovery;
9. write receipt and task readback.

Blocked behavior:

- repeated apology/explanation loops;
- "I stop" without recovery action;
- asking the owner to choose routine diagnostics;
- long internal reasoning dumps;
- client-facing claims without green claim ledger.

Allowed owner crisis output:

```text
Fact: <known service state in one line>
Action: <current safe recovery action in one line>
Left: <none or exact owner-only irreversible blocker>
```

## Safe Rollback Lane

Rollback is allowed only when all are true:

- task and RUN are bound;
- environment proof is `PRODUCTION` or `PROD_RISK_UNKNOWN` under incident;
- last-known-good revision/deployment is proven;
- rollback path is pre-registered, scoped, reversible, and non-destructive;
- rollback checkpoint exists;
- action does not touch databases, proxy, firewall, runtime config, global
  infrastructure, secrets, or broad restarts unless a later exact authority
  explicitly covers that surface;
- validation and receipt are mandatory after rollback.

Feature fixes on production are always
`PRODUCTION_FIX_OUTSIDE_ROLLBACK_LANE_BLOCKED`.

## PR171 / Gitleaks Terminal Closure Gate

For PR171/AH-794 style closure:

- Treat it as a point-fix terminal gate, not a general policy replacement.
- Do not close from chat-only status, weak CI, task creation, branch existence,
  or partial validation.
- Required evidence: PR state, branch state, gitleaks/security gate, merge gate,
  task readback or typed task-service blocker, register updates, and no
  same-scope open tail.
- If branch protection/platform state blocks merge, record
  `PLATFORM_BRANCH_PROTECTION_GATE`.
- If security/gitleaks proof is missing, record
  `PR171_GITLEAKS_MERGE_GATE_BLOCKED`.

## Done Gate

Done requires:

- four-prompt claim ledger;
- installed policy/schemas/validator/fixtures/runbook/template/report/receipt;
- validator pass;
- register/index/PR queue coverage or typed blocker;
- task readback or typed task-service blocker;
- no forbidden surface touched;
- no product/runtime mutation;
- no same-scope open tail, or exact platform blocker.

Never claim Done from:

- GitHub workflow success alone;
- PR merged alone;
- local-only check for browser/user outcome;
- sandbox-only worker proof;
- report-only artifact;
- fake or placeholder task ids;
- owner anger or pressure.

## Typed Blockers

Allowed blockers:

- `TASK_BINDING_MISSING`
- `AGENTHUB_ROUTE_MISSING`
- `ENVIRONMENT_CLASSIFICATION_MISSING`
- `TEST_ONLY_ROUTE_PROOF_MISSING`
- `WORKFLOW_IMPACT_AUDIT_MISSING`
- `PROD_RELEASE_AUTHORIZATION_MISSING`
- `SAFE_ROLLBACK_LANE_MISSING`
- `LAST_KNOWN_GOOD_REVISION_MISSING`
- `OWNER_INCIDENT_SIGNAL_NOT_ROUTED`
- `PRODUCTION_FIX_OUTSIDE_ROLLBACK_LANE_BLOCKED`
- `PR171_GITLEAKS_MERGE_GATE_BLOCKED`
- `PLATFORM_BRANCH_PROTECTION_GATE`
- `REGISTER_INDEX_UPDATE_BLOCKED`
- `VALIDATOR_FIXTURE_FAIL`
- `TASK_SERVICE_PHYSICAL_WRITE_STILL_FAILS`
- `OWNER_ONLY_IRREVERSIBLE_GATE`

