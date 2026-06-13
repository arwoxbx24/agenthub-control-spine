---
artifact_id: permanent-user-outcome-validation-policy
artifact_type: governance_policy
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-788
run_id: permanent-user-outcome-validation-governance-20260613
created_at: 2026-06-13
lifecycle_status: active_control
default_load: false
safe_to_replay: false
supersedes: none
---

# Permanent User-Outcome Validation Policy

## Purpose

AgentHub/Codex/YouTrack/GitHub work must close from user outcome evidence, not narrative confidence, local-only checks, screenshots without path context, or PR existence.

## State Machine

1. INTAKE: bind one YouTrack task, one RUN_ID, duplicate signature, repository, branch, role, skills, negative matches.
2. PRE-FLIGHT: list target surfaces, forbidden surfaces, validation matrix rows, and Done proof tuple.
3. PLAN: build a closed contour from objective to receipt and readback. No unbounded exploration.
4. ACT: mutate only scoped governance surfaces. After a gate error, read the exact validator or schema before one targeted retry.
5. VALIDATE: run all in-scope rows of the scoped validation matrix.
6. PACKFIX: routine missing route/proof/register/queue/parser/browser evidence becomes same-RUN PackFix, not owner chat.
7. CLAIM LEDGER: every client or user-facing claim must be green with direct evidence or removed.
8. CLOSE: Stage Done is last and requires exact markers.

## Done Markers

YouTrack Done is allowed only when the issue description or approved fields include exactly:

```text
Implementation evidence: <installed control/diff/artifact path>
Validation evidence: <test/eval/readback proof>
Receipt: <receipt path or route receipt>
Blocker: none
```

Pending, remaining, later, needs user, validation missing, browser missing, local-only proof, sandbox-only proof, PR-only proof, or unresolved child text blocks Done.

## Browser/User-Story Rule

When a user-visible feature, service, UI, public route, client delivery, or product outcome is in scope, browser/user-story evidence is primary. Curl, process status, logs, local sockets, PM2, systemd, and screenshots are supporting evidence only. Screenshot evidence must identify the user story, route, expected result, and whether backend/API state was separately checked.

## Full Coverage Definition

Full coverage means 100% completion of declared in-scope validation matrix rows. It never means infinite tests, random screenshots, broad filesystem scans, unbounded token loops, or arbitrary retries.

## Blocked Behaviors

- `BLIND_RETRY_AFTER_GATE_FAIL_BLOCKER`: same failed gate repeated without reading exact guard/source.
- `LOCAL_ONLY_PROOF_BLOCKER`: user-facing Done from local socket/curl/process only.
- `BROWSER_PROOF_MISSING_BLOCKER`: user-visible scope without browser/user-story proof.
- `UNSUPPORTED_CLIENT_CLAIM_BLOCKER`: full-delivery claim with unknown/partial claim ledger entries.
- `ROUTINE_BLOCKER_TO_OWNER_CHAT_BLOCKER`: routine validation/platform gap sent to owner instead of PackFix.
- `RANDOM_FOLDER_SPRAWL_BLOCKER`: unregistered temp/report/run folder creation.
- `UNBOUNDED_TEST_REQUEST_NORMALIZER`: vague many/full/all tests normalized to scoped matrix.
- `SCREENSHOT_WITHOUT_USER_STORY_BLOCKER`: screenshot with no mapped user path.
- `STAGE_DONE_WITH_PENDING_TEXT_BLOCKER`: Done attempted with residual pending text.
- `EXACT_DONE_MARKER_DRY_RUN_REQUIRED`: Done requires canonical marker dry-run/readback.

## Communication Protocol

Ask only when required and unavailable through safe tools. Ask one focused question at a time. Do not guess; mark uncertainty. State tradeoffs only when a real decision is required. Keep owner chat concise, critical, practical, and free of logs/JSON/internal matrices. If the owner says `Подожди, блин`, freeze scope growth and restate current objective, known facts, unknowns, and next safe action in one short message.

## Forbidden Scope

This policy does not authorize runtime, Docker, DB, proxy/NPM, firewall, PM2, Grafana, DNS, SSL, object storage, production service, client project code, secrets, broad cleanup, delete, prune, reset, or unmanaged temp mutation.
