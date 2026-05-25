---
artifact_id: agenthub-safe-recovery-control
artifact_type: governance-control
owner_role: T1 Architecture Broker
source_task: AH-534
related_tasks:
  - AH-535
  - AH-536
  - AH-537
run_id: RUN-agenthub-safe-recovery-control-20260525
created_at: 2026-05-25
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Safe Recovery Control

## Purpose

This control prevents AgentHub/Codex work from ending in blocker loops, fake success reports, stale prompt replay, or unsafe direct runtime mutation. It applies to control-spine governance work and to live incidents that require an authorized AgentHub worker route.

## Safe Language Reset

When an incident request contains panic, profanity, or unsafe cyber-adjacent wording, agents must rewrite it internally into neutral operational language before routing. The rewrite must preserve the business goal and must not attempt to bypass platform safety systems.

Required safe wording:

- authorized maintenance for owned infrastructure;
- exact YouTrack task and RUN_ID;
- allowed surface and forbidden surface;
- no exploitation, credential extraction, stealth, persistence, malware, broad public scanning, secret exposure, or destructive cleanup;
- validation and typed blocker requirements.

## Design Decision

| Option | Decision | Reason |
|---|---|---|
| A. Conservative prompt/register cleanup only | rejected | It does not solve live-adapter blocker loops or Done taxonomy failures. |
| B. Mandatory skill router, task gates, registers, safe live-adapter contract | accepted | Smallest durable fix for the observed failures. |
| C. Full policy-as-code runtime automation | deferred | Useful later, but too broad for the current corrective package. |

## Mandatory Control Gates

1. Task-first gate: every implementation or runtime action must be tied to YouTrack task id, RUN_ID, worker id, scope, evidence, and receipt.
2. Role gate: T0 may route, verify, register, and report; T0 must not mutate runtime, Docker, DB, proxy, firewall, ports, secrets, product code, or live services.
3. Parent/child gate: parent tasks cannot move to Done while implementation children remain open, failed, unvalidated, or blocked, unless the parent is explicitly tracking-only.
4. Evidence gate: Done requires implementation evidence, validation evidence, control-spine receipt, task readback, and no active blocker.
5. Runtime safety gate: Docker, DB, proxy, firewall, DNS, SSL, object storage, and service changes require an authorized worker, rollback/checkpoint, and validation.
6. Artifact lifecycle gate: reports are evidence, receipts are proof, prompts are not replayable by default, and old artifacts must not become active instructions unless `ARTIFACT_REGISTER.md` says so.
7. PR queue gate: every open PR must have queue class, owner, source task, RUN_ID, next action, and blocker if any.
8. Final-output gate: user chat must be compact Russian Caveman format: `Fact`, `Action`, `Left`.

## Live Incident Rule

A live 500/502 incident may proceed only through an authorized AgentHub worker route. If `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` or an equivalent adapter blocker appears, direct T0 shell fallback remains invalid. The same run must update the blocker task and receipt instead of asking the user to operate the platform.

## Docker/DB/Proxy Safety Rule

Forbidden without explicit scoped worker authorization:

- `docker rm`, `docker system prune`, `docker volume rm`, `docker compose down -v`, broad image/container cleanup;
- deleting or recreating active volumes, running containers, linked networks, DB files, repositories, backups, or logs needed for diagnosis;
- DB dump/query/migration/restore;
- proxy/firewall/DNS/SSL mutation;
- secret/env/private-key inspection or printing.

Allowed first step for an authorized incident worker:

- read-only service ownership map;
- container/process/health summary;
- disk/inode/memory/port summary;
- upstream/downstream route chain;
- bounded endpoint validation;
- rollback/checkpoint plan before any mutation.

## Completion States

Only these final states are valid:

- `DONE_WITH_EVIDENCE`
- `READY_BLOCKED_BY_PLATFORM_GATE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `FORBIDDEN_SCOPE_BLOCKER`
- `INSTRUCTION_SOURCE_DRIFT`
- `WRONG_TASK_CLASS_BLOCKER`
- `SAFETY_QUARANTINE`

Generic `blocked`, chat-only `done`, green curl only, PR-only success, task creation only, sandbox-only proof, or T0-only evidence are invalid.