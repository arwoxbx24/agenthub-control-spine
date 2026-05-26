---
artifact_id: agenthub-permission-profile-matrix
artifact_type: governance-policy
owner_role: T1 Architect / Registrar
source_task: AH-570
run_id: RUN-P0-system-permission-core-versioning-20260526
created_at: 2026-05-26
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Permission Profile Matrix

## Purpose

This matrix separates safe control-plane work from dangerous runtime work.
Agents must use the narrowest profile that can satisfy the task.

## Profiles

| Profile | Allows | Blocks | Evidence |
|---|---|---|---|
| `T0_CONTROL_AUDIT` | read current task/status/repo context; classify; route; write reports/receipts; update YouTrack evidence; create permission manifests | shell mutation; code edit; Docker; DB; proxy; firewall; secrets; runtime/product/client changes | route receipt, task readback, control-spine receipt |
| `REGISTRAR_CONTROL_SPINE` | scoped branch/PR; `INDEX.md`; `ARTIFACT_REGISTER.md`; `PR_QUEUE_REGISTER.md`; artifact lifecycle; prompt quarantine/supersede | runtime mutation; product work; secrets | PR diff, register diff, receipt |
| `T1_ARCHITECT_CONTROL` | architecture contracts; policy-as-code design; validation plans; permission matrix updates by PR | direct runtime/product mutation | architecture report, schema, eval fixtures |
| `T2_SCOPED_WORKER` | assigned implementation surface after rollback/evidence gates | unrelated services/repos; secrets; destructive broad cleanup | rollback plan, implementation evidence, validation evidence |
| `VERIFIER_READONLY` | read-only validation; screenshots; redacted log summaries; result checks | mutation | verifier report |
| `BREAK_GLASS_CONTROLLED` | emergency scoped repair when owner-authorized or covered by installed emergency policy | global root; broad prune/reset/delete; unrelated services | owner/emergency gate, one writer, rollback, live receipt, verifier |

## T2 Subprofiles

- `T2_DEVOPS_REPAIR`
- `T2_APP_WORKER`
- `T2_PROXY_EDGE_WORKER`
- `T2_REPO_PATCH_WORKER`
- `T2_QA_BROWSER_WORKER`

Each subprofile must include task id, run id, allowed surface, forbidden
surface, rollback plan, validation plan, evidence paths, and expiry.

## Safe Action Auto-Allow

The following are allowed when scoped, redacted, and task-bound:

- read `AGENTS.md`, `INDEX.md`, `ARTIFACT_REGISTER.md`, `PR_QUEUE_REGISTER.md`,
  and current task fields;
- write control-spine reports/receipts on a scoped branch;
- update YouTrack evidence/readback without changing unrelated tasks;
- register artifacts and PR queue rows for the active scope;
- verifier read-only checks;
- prompt scoring and red-team checks;
- active-scope branch/PR hygiene;
- permission manifest creation.

## Dangerous Action Gate

The following are never auto-allowed:

- DB writes or migrations;
- proxy/edge mutations;
- Docker/service mutation;
- firewall/DNS/SSL changes;
- secrets/env access;
- destructive cleanup/reset/prune/delete;
- production deploy/restart;
- client product code changes;
- broad Linux commands outside the assigned surface.

They require a T2 profile, rollback, scoped authority, receipt, and verifier.

## Missing Permission Rule

An agent that lacks authority must write exactly one permission manifest using
`schemas/permission-manifest.schema.json`. It must not create duplicate tasks or
retry the same blocker loop.
