---
artifact_id: AH-536-AH-554-repo-first-runtime-closure-audit-20260525
artifact_type: corrective-audit
owner_role: T0 Registrar / Verifier
source_task: AH-536/AH-554
run_id: RUN-agenthub-repo-first-ah536-ah554-audit-20260525
created_at: 2026-05-25
status: blocked
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# AH-536 / AH-554 Repo-First Runtime Closure Audit

## Task IDs

- Parent incident: `AH-536`.
- Child runtime repair: `AH-554`.
- Related readback only: `AH-521`.

## Role Routing

- T0: registrar/readback only.
- T2 live DevOps worker: required for Docker/NPM/edge/runtime mutation.
- Verifier: read-only endpoint and repository evidence checks.

## Selected Skills

- `agenthub-task-first-router`
- `agenthub-registrar-artifact-lifecycle`
- `agenthub-git-pr-queue-control`
- `agenthub-truth-redteam`
- `agenthub-permission-gate-router`
- `agenthub-live-devops-safety`
- `agenthub-devops-incident-worker`
- `agenthub-browser-user-outcome-qa`
- `agenthub-security-redaction`
- `caveman-user-communication`

## Source Files Read

- `AGENTS.md`
- `INDEX.md`
- `ARTIFACT_REGISTER.md`
- `PR_QUEUE_REGISTER.md`
- `context/agenthub-current-context-pack.md`
- `governance/agenthub-only-execution-discipline.md`
- `governance/agenthub-docker-db-proxy-safety-policy.md`
- `governance/agenthub-access-rights-and-live-worker-enablement-policy.md`
- `governance/agenthub-task-cycle-full-closure-policy.md`
- `runbooks/agenthub-502-live-runtime-recovery-safe-runbook.md`

## Current Evidence

The latest read-only public endpoint recheck after the prior closure claim shows
the live runtime is not closed:

| Endpoint | Result |
|---|---|
| `port.b244.ru` | `502` |
| `dash.b244.ru` | `200` |
| `minio-admin.b244.ru` | `502` |
| `git.b244.ru` | `502` |
| `yubikey-v1.b244.ru` | `502` |
| `yubikey-v2.b244.ru` | `502` |
| `transcribe.b244.ru` | `502` |
| `dev.transcribe.b244.ru` | `502` |
| `pdf-generator.b244.ru` | `502` |
| `vphdffy.b244.ru` | `502` |
| `arwox.b244.ru` | `502` |
| `kpd.b244.ru` | `502` |
| `yt.b244.ru` | `200` |

Owner exclusions remain:

- Appsmith/BMC `20120` is out of scope and must not be touched.
- n8n / `http://n8n:5678` is out of scope for this pass.

## Gate Verdict

| Gate | Verdict | Reason |
|---|---|---|
| `REPO_BINDING_GATE` | PASS | Audit and receipt are in the canonical repo. |
| `TASK_FIRST_GATE` | PASS | Existing AH-536/AH-554 were read; no duplicate task created. |
| `ROLE_BOUNDARY_GATE` | FAIL | Prior live mutation was performed from the primary/T0 shell path, not accepted T2 worker evidence. |
| `LIVE_AUTH_GATE` | FAIL | No accepted live T2 worker mutation receipt exists for the current broken public endpoints. |
| `NO_BMC_GATE` | PASS | No Appsmith/BMC `20120` action in this corrective audit. |
| `NO_SECRET_GATE` | PASS | No secrets or raw env values included. |
| `RUNTIME_REPAIR_GATE` | FAIL | Public endpoint matrix still has active 502s. |
| `DONE_GATE` | FAIL | Stage Done cannot be accepted while runtime/user outcome is broken. |

## Blocker

Primary blocker: `AGENTHUB_LIVE_WORKER_ROUTE_BLOCKED`.

Reason: the runtime chain requires a task-bound T2 live DevOps worker with P5/P8
authority, rollback/checkpoint, and endpoint validation. Direct primary/T0 shell
mutation is invalid evidence under the current control-spine policies and must
not be used to claim Done.
