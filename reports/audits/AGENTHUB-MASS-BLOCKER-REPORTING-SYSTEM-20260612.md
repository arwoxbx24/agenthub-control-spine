---
artifact_id: agenthub-mass-blocker-reporting-system-20260612
artifact_type: reporting-system-audit
owner_role: T0 Registrar / T1 Architecture Broker / Verifier
source_task: AH-770
run_id: RUN-AGENTHUB-MASS-BLOCKER-REPORTING-SYSTEM-20260612
created_at: 2026-06-12
lifecycle_status: active_control_candidate
default_load: false
safe_to_replay: false
---

# AgentHub Mass Blocker Reporting System

## Purpose

This report explains why mass blockers are appearing and defines a repeatable reporting system. It separates true owner-only blockers from platform defects that should become same-RUN PackFix work.

## Executive summary

Mass blockers are not coming from one service outage. They come from control-plane contract mismatch:

1. Local shell/read path is blocked by task pre-dispatch guard.
2. AgentHub command-worker is disabled by contract-only runtime policy.
3. Large register append has no safe append route, so register coverage stalls.
4. Done gate parses evidence too narrowly unless description and fields are updated atomically.
5. Old blockers remain searchable after completion, creating false recurrence signals unless blocker fields are normalized.

## Reporting fields

Every blocker record must include:

- `blocker_id`
- `blocker_class`
- `first_seen_task`
- `current_task`
- `surface`
- `symptom`
- `root_cause`
- `evidence`
- `routine_or_owner_only`
- `lane`
- `repair_action`
- `status`
- `next_readback`

## Current blocker taxonomy

| Blocker | Class | Surface | Evidence | Root cause | Correct lane | Status |
|---|---|---|---|---|---|---|
| `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID` | task gate defect | local shell / pretool | direct skill/file read attempts blocked even with visible task context | task id binding is not propagated into local shell guard | Lane 3 task/run self-healing | open platform defect |
| `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` | worker route defect | AgentHub command-worker | AH-767 RUN merge returned BLOCKED, done_allowed=false | non-sandbox adapter disabled; no authorized command-worker route for routine validation | Lane 3/6 route repair | open platform defect |
| `REGISTER_APPEND_ROUTE_PENDING` | registrar tooling defect | GitHub registers | AH-767 could create PR #160 and patch artifact, but not safe append large registers | connector supports full-file replace but not deterministic append for large registers | Lane 2 registrar append route | open |
| `DONE_GATE_DEFECT` | closure parser defect | YouTrack Done transition | AH-747/AH-755/AH-762 required atomic description+field update before Done | gate reads exact markers and can ignore partial evidence fields | Lane 3 Done field normalizer | repaired for observed tasks |
| stale blocker fields | status hygiene defect | YouTrack search/readback | Done tasks still contained old blocker strings in non-current fields | historical evidence and active blocker state are mixed | Lane 2/3 blocker field normalization | partially repaired |

## Why it feels like mass blocking

A single real issue expands into many visible blockers because each layer reports independently:

- local shell reports pre-dispatch block;
- AgentHub reports command-worker block;
- YouTrack reports Done/readback block;
- GitHub/register layer reports append/PR queue block;
- final assistant must refuse green Done because one layer remains red.

Without a root-cause report, these look like separate failures. They are mostly one family: missing or inconsistent authority propagation between task, RUN, worker adapter, registrar, and Done parser.

## Required dashboard views

1. **Active platform blockers**: unresolved blocker classes with count by surface.
2. **Routine PackFix queue**: blockers that must not reach owner chat.
3. **Owner-only blockers**: legal/payment/secret/destructive authority only.
4. **False recurrence watchlist**: Done tasks that still contain old blocker strings.
5. **Token burn signals**: repeated same blocker, duplicate task, duplicate PR, prompt dump, full artifact reload.

## Remediation plan

1. Implement task-id propagation proof for local shell guard.
2. Add authorized command-worker validation route or explicit command-worker PackFix task.
3. Add safe append helper for `INDEX.md`, `ARTIFACT_REGISTER.md`, and `PR_QUEUE_REGISTER.md`.
4. Standardize atomic YouTrack Done update: description + implementation evidence + validation evidence + receipt + no-blocker marker + Stage=Done in one call.
5. Add blocker-state normalization: old blocker evidence stays in comments/receipts; current blocker field must be `NO_BLOCKER` after closure.
6. Add dashboard query pack for blocker class, stage, RUN_ID, and owner.

## Done rules for this reporting system

This reporting system is complete when:

- this report exists in repository;
- machine-readable blocker ledger exists;
- AH-770 records implementation and validation evidence;
- PR/readback evidence exists;
- remaining non-report platform defects are explicitly listed and not hidden as green status.
