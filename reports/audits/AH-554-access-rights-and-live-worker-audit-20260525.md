---
artifact_id: ah554-access-rights-and-live-worker-audit-20260525
artifact_type: audit-report
owner_role: T1 Architecture Broker
source_task: AH-554
related_tasks:
  - AH-536
  - AH-537
run_id: AGENTHUB-P0-ACCESS-RIGHTS-AUDIT-LIVE-DEVOPS-ENABLEMENT-20260525
created_at: 2026-05-25
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# AH-554 Access Rights And Live Worker Audit

## Prompt Quality Self-Gate

Score: 93/100.

Strong points: task identity, source hierarchy, role boundaries, safety gates,
evidence rules, closure format.

Risk: large scope. Mitigation: one closed-loop repo control package plus existing
task lineage only. No new broad tasks.

## Task Lineage

| Task | Status readback | Role in lineage | Evidence class |
|---|---|---|---|
| AH-536 | Develop | Parent live 502 incident | VERIFIED_BY_YOUTRACK |
| AH-554 | Develop | Child endpoint matrix and live restoration task | VERIFIED_BY_YOUTRACK |
| AH-537 | Done | Historical scoped adapter route evidence for earlier AH-536 route | VERIFIED_BY_YOUTRACK |
| AH-521 | Develop | OpenClaw/claw residual, excluded from AH-554 | VERIFIED_BY_YOUTRACK |

No new task family was created. AH-554 already exists and carries the current
endpoint restoration scope.

## Claim Ledger

| Claim | Verdict | Evidence | Lane |
|---|---|---|---|
| Canonical repo is `arwoxbx24/agenthub-control-spine` | VERIFIED_BY_REPO | AGENTS.md and GitHub repo metadata | A |
| GitHub write route exists for control-spine | VERIFIED_BY_REPO | GitHub repo permissions include push/admin | A |
| Open PR for AH-536/AH-554 access-rights scope already exists | CONTRADICTED | GitHub PR search returned no matching open PR | A |
| AH-554 is child of AH-536 | VERIFIED_BY_YOUTRACK | AH-554 parentIssue AH-536 | B |
| AH-537 is Done for older scoped route | VERIFIED_BY_YOUTRACK | AH-537 Stage Done and comments | B/C |
| AH-537 proves current AH-554 mutation authority | CONTRADICTED | AH-554 still has worker/auth blocker and no mutation receipt | D |
| Current endpoint matrix has active runtime failures | VERIFIED_BY_YOUTRACK | AH-554 validation fields and comment | D |
| MinIO/agent_share failure is global blocker | CONTRADICTED | Policy and prior evidence provide GitHub/YouTrack fallback | F |
| T0 can mutate runtime to finish AH-554 | CONTRADICTED | AGENTS.md and current context forbid T0 runtime mutation | D |

## Access Audit

| Surface | Current state | Needed for AH-554 | Blocker |
|---|---|---|---|
| GitHub repo | Write/admin available | P1 repo artifact write | none |
| PR queue | No matching open PR before this package | PR queue register entry | none |
| YouTrack | AH-536/AH-554/AH-537 readable/writable | P2 task updates | none |
| AgentHub MCP | Reconcile and ownership bind available | P3 control receipt | none for control lane |
| Live worker mutation | Ownership bound to W-devops-06, but no authorized runtime mutation executed | P5/P8 worker grant | AGENTHUB_LIVE_WORKER_AUTH_MISSING |
| Evidence transport | GitHub/YouTrack/local receipts available | Evidence fallback | none; MinIO not global |
| Runtime endpoints | AH-554 matrix shows many 502/DNS failures | P4/P5/P8 repair | runtime local blocker |

## Blocker Taxonomy

| Blocker | Classification | Affected scope | Global? | Next route |
|---|---|---|---|---|
| AH-554 live mutation route missing | WORKER_AUTH_MISSING | Lane D, AH-554 endpoints | No | Authorize scoped T2 DevOps worker with P4/P5 and P8 only if needed |
| NPM/proxy safety | VALID_LOCAL_SAFETY_GATE | Exact proxy host changes only | No | Backup config, exact host, rollback, external validation |
| DB dependency for any service | VALID_LOCAL_SAFETY_GATE | Service-specific DB only | No | P6 backup before DB action |
| MinIO/agent_share down | EVIDENCE_TRANSPORT_LOCAL_FAILURE | Lane F evidence publishing | No | Use GitHub/YouTrack/local receipt fallback |
| AH-536 parent while AH-554 open | TASK_GRAPH_DEFECT if closed as Done | Task graph | No | Keep AH-536 open or mark tracking-only |

## Architecture Options

Conservative: only clarify blockers. Rejected because AH-554 still lacks a
workable live-worker route.

Balanced: install P0-P9 capability matrix, live-worker authorization schema,
Docker/DB/proxy safety gates, task-cycle closure policy, runbooks, skills, and
evals. Accepted.

Progressive: build an automated capability broker and remediation queue.
Rejected for this run because it requires broader platform authority and higher
runtime blast radius.

## AH-554 Endpoint Matrix Summary

Readback from AH-554:

- 200: dash, yt.
- 502: port, minio-admin, n8, git, yubikey-v1, yubikey-v2, transcribe,
  pdf-generator, vphdffy, arwox.
- DNS_NOT_RESOLVED: cgit, dev-transcribe, stroy.
- Protected-link gate: b244.ru and io.b244.ru not checked by direct curl.
- Excluded: claw via AH-521, kpd deferred by user.

## Installed Controls

- Access capability matrix P0-P9 policy.
- Docker/DB/proxy safety policy.
- Full task-cycle closure policy.
- Capability matrix schema.
- Live-worker authorization schema.
- Access audit/live DevOps enablement runbook.
- 502 live runtime recovery runbook.
- Permission gate router skill.
- Live DevOps safety skill.
- Regression fixtures for access rights and live-worker gates.

## Residual Blocker

Final state for live runtime lane:
`READY_BLOCKED_BY_PLATFORM_GATE` / `AGENTHUB_LIVE_WORKER_AUTH_MISSING`.

This blocks AH-554 runtime restoration only. It does not block repo controls,
YouTrack updates, PR queue, or evidence fallback.

## Security

No secrets, raw environment variables, tokens, private keys, cookies, DB dumps,
raw admin credentials, or raw internal transcript links are included.
