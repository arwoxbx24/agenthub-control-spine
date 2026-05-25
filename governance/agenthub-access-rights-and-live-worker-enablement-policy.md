---
artifact_id: agenthub-access-rights-and-live-worker-enablement-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker
source_task: AH-554
related_tasks:
  - AH-536
  - AH-537
run_id: AGENTHUB-P0-ACCESS-RIGHTS-AUDIT-LIVE-DEVOPS-ENABLEMENT-20260525
created_at: 2026-05-25
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Access Rights And Live Worker Enablement Policy

## Purpose

This policy separates false platform blockers from valid safety gates. It does
not make AgentHub permissive. It allows only scoped, task-bound, evidence-bound
work while preserving T0 runtime boundaries and Docker/DB/proxy safety.

## Architecture Decision

Decision: Balanced scoped capability model.

Rejected alternatives:

- Conservative: keep only stricter blocker wording. Rejected because AH-554
  needs a usable live-worker route, not another status-only blocker.
- Progressive: build an automated runtime capability broker now. Rejected
  because it requires broader platform authority and higher operational risk.

The accepted model is deny-by-default plus explicit permission classes P0-P9.
Each grant must name task, RUN, worker, allowed surface, denied surface,
evidence, rollback where needed, and blocker fallback.

## Access Capability Matrix

| Class | Capability | Allowed roles | Required evidence | Approval source | Denied conditions | Fallback route | Blocker |
|---|---|---|---|---|---|---|---|
| P0_CONTROL_READ | Read repo/task/evidence/status | T0, T1, Registrar, Verifier | Source pointer and evidence class | System + task scope | Secret/raw env/transcript dump | Redacted summary | `SAFETY_QUARANTINE` |
| P1_REPO_ARTIFACT_WRITE | Control-spine artifact write | Registrar, scoped repo worker | Branch/PR, diff, index/register/receipt, secret scan | YouTrack task + AgentHub route + GitHub auth | Wrong repo owner, unrelated files, no register | PR queue entry | `GITHUB_WRITE_ROUTE_REQUIRED` |
| P2_YOUTRACK_TASK_WRITE | Task fields, links, comments, stages | T0, Registrar, task worker | Duplicate check, task readback, child state | YouTrack auth + task lineage | Fake Done, parent with open child, task explosion | Existing parent/child route | `YOUTRACK_API_AUTH_REQUIRED` |
| P3_MCP_CONTROL | AgentHub MCP tool and ledger actions | T0, T1, worker under receipt | Real MCP receipt, RUN_ID, task_id | AgentHub MCP route | Env-only proof, shell-only proof, missing receipt | Report MCP route gap | `AGENTHUB_MCP_TOOL_UNAVAILABLE` |
| P4_LIVE_RUNTIME_READ | Runtime status, endpoint, Docker status/log summary, NPM read, DB status read without secrets | Verifier or T2 DevOps worker | Scoped read-only receipt, redacted output, no mutation | Live read adapter or scoped worker | Secret dump, broad logs, DB content query | Public endpoint fallback or owner route | `DOCKER_HOST_ACCESS_MISSING` / `PORTAINER_ACCESS_MISSING` |
| P5_LIVE_RUNTIME_MUTATE | Restart/recreate scoped services, fix scoped compose/upstream, reload scoped proxy | T2 DevOps worker only | Preflight, exact service, checkpoint/rollback, before/after validation | Existing task + scoped live worker grant | T0 action, broad cleanup, unrelated service, no rollback | AH-537/AH-554 platform remediation | `AGENTHUB_LIVE_WORKER_AUTH_MISSING` |
| P6_DB_BACKUP_AND_SAFE_DB_ACTION | DB backup and non-destructive DB action | T2 DB-capable worker | Backup proof, restore note, no raw data, exact DB scope | Explicit task scope + DB authorization | No backup, destructive operation, raw records | Owner gate or no-DB workaround | `DB_BACKUP_AUTH_MISSING` |
| P7_DOCKER_DESTRUCTIVE_CLEANUP | Remove exact stopped obsolete Docker targets | T2 DevOps worker with owner gate | Proof stopped/detached/obsolete, no active compose/volume, rollback note | Explicit task authorization | Running container, active volume, linked network, broad prune/reset | Safer non-delete repair | `OWNER_ONLY_DESTRUCTIVE_DELETE_GATE` |
| P8_PROXY_FIREWALL_EDGE | NPM/proxy/firewall/DNS/SSL change | T2 edge worker | Exact host, config backup, rollback, external validation | Explicit edge authorization | Global config, unrelated host, no backup | Read-only matrix + typed blocker | `PROXY_CONFIG_AUTH_MISSING` / `FIREWALL_DNS_SSL_OWNER_GATE` |
| P9_SECRET_OR_ACCOUNT_GATE | Secrets, tokens, account login, licenses | Owner or approved secret route | Secret-manager/OAuth receipt, never raw value | Owner/account authority | Raw secret in chat/artifact, credential guessing | Ask owner only when no agent route exists | `SAFETY_QUARANTINE` |

## Grant Rules

1. A permission class is granted only for named tasks and services.
2. T0 cannot hold P4-P8 mutation authority.
3. P5-P8 require a worker receipt before action and validation after action.
4. P6 requires backup before DB mutation; backup metadata must not expose data.
5. P7 never permits broad `docker system prune`, active volume deletion, or
   running-container removal.
6. P8 never permits unrelated NPM/proxy/firewall/DNS changes.
7. Missing MinIO/agent_share is evidence transport only and must not block repo,
   YouTrack, or GitHub evidence paths.

## AH-554 Grant

AH-554 may request:

- P4 for endpoint, Docker, compose, port/listener, and NPM upstream read.
- P5 for scoped restart/recreate of already-owned broken endpoint services.
- P8 only for exact proxy host repair when mismatch is proven and config backup
  exists.
- P6 only if a named service requires DB action and backup is proven first.

AH-554 currently excludes `claw` and `kpd` per user instruction. Exclusions must
be written into the endpoint matrix and must not count as AH-554 failure.

## Final State

Repo/task lanes may complete while lane D remains blocked. AH-536 cannot close
as runtime Done while AH-554 is open unless AH-536 is explicitly changed to
tracking-only and readback records that AH-554 owns remaining implementation.
