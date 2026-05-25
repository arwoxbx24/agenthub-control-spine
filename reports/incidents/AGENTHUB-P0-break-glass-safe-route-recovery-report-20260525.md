---
artifact_id: AGENTHUB-P0-break-glass-safe-route-recovery-report-20260525
artifact_type: corrective-incident-report
owner_role: T0 Registrar / T1 Route Architect / T2 Worker / Verifier
source_task: AH-567 / AH-536 / AH-554
run_id: RUN-agenthub-p0-break-glass-safe-route-20260525
created_at: 2026-05-25
status: blocked-by-edge-npm-auth
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# AgentHub P0 Break-Glass Safe Route Recovery Report

## Executive Result

The break-glass owner authorization was applied to stop the self-blocking
AgentHub loop. Repository evidence was written first, a scoped AgentHub T2 live
worker route was activated, one T2 worker ran through AgentHub, and a verifier
performed read-only public endpoint validation.

The incident is not runtime Done. The public endpoint matrix still has active
`502` responses, and the remaining blocker is:

`EDGE_NPM_AUTH_REQUIRED`

This report is the detailed report artifact for the same final receipt:

`reports/receipts/AGENTHUB-P0-break-glass-safe-route-recovery-final-receipt-20260525.md`

## Task Chain

- `AH-567`: P0 route/freeze-loop control issue.
- `AH-536`: parent runtime incident.
- `AH-554`: child runtime repair issue.

No new YouTrack task was created for this chain. No new PR was opened. The
existing branch `agenthub/ah536-ah554-final-receipt-20260525` was reused.

## Files Written

- `governance/agenthub-break-glass-safe-route-recovery-profile-ah536-ah554-ah567.md`
- `reports/receipts/AGENTHUB-P0-break-glass-safe-route-recovery-start-receipt-20260525.md`
- `reports/receipts/AGENTHUB-P0-break-glass-safe-route-recovery-final-receipt-20260525.md`
- `reports/incidents/AGENTHUB-P0-break-glass-safe-route-recovery-report-20260525.md`
- `INDEX.md`
- `ARTIFACT_REGISTER.md`
- `PR_QUEUE_REGISTER.md`

## Role Execution

| Role | Result |
|---|---|
| T0_CONTROL | Wrote repo/task control evidence only. No runtime, Docker, NPM, DB, proxy, firewall, product, or client-code mutation. |
| T1_ROUTE_ARCHITECT | Recorded break-glass route profile and adjusted the command-worker allowlist for the authorized route. |
| REGISTRAR | Registered profile, receipts, report, index/register/queue entries. |
| T2_CODEX_LIVE_WORKER | Ran through AgentHub command route; performed scoped endpoint/Docker readback and known-container safe-start pass only. |
| VERIFIER | Ran read-only public endpoint matrix. |

## Route Repair

The first break-glass run recorded the route profile and start receipt:

- RUN_ID: `RUN-agenthub-p0-break-glass-safe-route-20260525`
- T1 worker: `T1-break-glass-route-architect-01`

The first attempt to add a command worker to the same run was blocked by the
AgentHub v2 one-worker lifecycle and a contract-only dispatch residual. The
route defect was not treated as final. A scoped emergency worker-route run was
used for the T2 worker:

- T2 RUN_ID: `agenthub-emergency-worker-route-unblock-ah536-ah554-20260525-2`
- T2 worker: `T2-codex-live-worker-ah536-ah554-01`
- T2 merge status: `SUCCESS`
- T2 evidence file:
  `@agenthub-runs/agenthub-emergency-worker-route-unblock-ah536-ah554-20260525-2/t2-live-worker-evidence.json`

Verifier route:

- Verifier RUN_ID:
  `agenthub-emergency-worker-route-unblock-ah536-ah554-verifier-20260525`
- Verifier worker: `VERIFIER-break-glass-ah536-ah554-01`
- Verifier evidence file:
  `@agenthub-runs/agenthub-emergency-worker-route-unblock-ah536-ah554-verifier-20260525/verifier-endpoint-evidence.txt`

## T2 Safe Action

T2 action scope was intentionally narrow:

- public endpoint matrix before repair;
- Docker availability check;
- exact known-container allowlist lookup;
- start only stopped known in-scope containers if present;
- public endpoint matrix after safe pass.

T2 did not perform:

- NPM/edge mutation;
- DB mutation;
- broad Docker cleanup;
- volume deletion;
- broad restart;
- firewall/DNS/global proxy mutation;
- BMC/Appsmith/port `20120` mutation;
- n8n mutation;
- Stroyremont/client-code mutation;
- secret or raw environment dump.

T2 result:

- No expected in-scope containers were visible in the accessible Docker surface.
- No container was started.
- Public matrix stayed unchanged.

## Public Endpoint Matrix

Verifier readback:

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

## Evidence Classification

| Claim | Evidence class | Verdict |
|---|---|---|
| Repo report now exists | VERIFIED_BY_REPO | PASS |
| Start receipt exists | VERIFIED_BY_REPO | PASS |
| Final receipt exists | VERIFIED_BY_REPO | PASS |
| T2 worker ran through AgentHub | VERIFIED_BY_AGENTHUB_LEDGER | PASS |
| Verifier ran through AgentHub | VERIFIED_BY_AGENTHUB_LEDGER | PASS |
| Public runtime is Done | CONTRADICTED | FAIL |
| Forbidden contours untouched | VERIFIED_BY_AGENTHUB_LEDGER / VERIFIED_BY_REPO | PASS |
| Remaining blocker is edge/NPM route access | VERIFIED_BY_RUNTIME_WORKER / VERIFIED_BY_VERIFIER | PASS |

## Five Whys

1. Why did the user see another blocker instead of success?
   Because the break-glass worker route was unblocked, but the current accessible
   runtime surface did not expose the expected upstream containers, and public
   `502` remained.

2. Why did T2 not repair NPM/edge directly?
   Because the safe route did not have authenticated affected-host NPM/edge
   configuration access. Without that route, editing or guessing proxy state
   would violate the scoped safety contract.

3. Why was a route report missing in the user's expectation?
   Because receipts were written, but a distinct long-form incident report for
   the break-glass pass had not been created yet. That was a reporting gap.

4. Why did earlier work multiply blockers?
   Because previous contracts converted missing live execution capability into
   terminal reports instead of a route-repair step with one T2 attempt.

5. Why did direct T0 mutation happen earlier in the chain?
   Because incident pressure was incorrectly treated as permission for primary
   shell action. The corrected architecture keeps T0 control-only and sends
   runtime work through AgentHub T2.

## Self-Critique

The control loop improved but still failed the user's expected outcome. The
agent should have created this full report at the same time as the final
receipt, because the user explicitly required all detailed reporting in the
repository. Writing only receipts left a gap between machine evidence and owner
readability.

The second weakness is route fragmentation. AgentHub v2 closed the first run
after T1, so the T2 worker required a second emergency worker-route run. This
was recorded, but it is architecturally weaker than a true multi-role same-run
chain. The route model should support a T1 route-repair phase, then T2, then
Verifier under one parent incident ledger.

The third weakness is insufficient affected-host NPM access. The T2 route could
prove public failure and safe Docker non-repair, but not read or update the
affected proxy host mapping. That means the remaining blocker is real, narrow,
and actionable.

## Corrective Architecture

The durable architecture should be:

- one parent AgentHub incident ledger with role phases;
- T1 route repair allowed before T2 dispatch;
- T2 live worker with scoped Docker and affected-host NPM capability;
- Verifier public endpoint matrix;
- Registrar report and receipt as separate artifacts;
- YouTrack readback after repository write;
- no direct T0 runtime mutation;
- no report-only closure without a worker attempt.

## Gate Verdict

| Gate | Verdict |
|---|---|
| Repository report exists | PASS |
| Repository receipts exist | PASS |
| Registers updated | PASS |
| YouTrack readback updated | PASS |
| T0 runtime mutation avoided in this pass | PASS |
| T2 executed through AgentHub | PASS |
| Verifier executed through AgentHub | PASS |
| Forbidden contours untouched | PASS |
| Public user outcome | FAIL |
| Done gate | FAIL |

## Final Blocker

`EDGE_NPM_AUTH_REQUIRED`

Exact missing item: authenticated affected-host NPM/edge configuration route for
the AH-536/AH-554 proxy hosts. The route must allow readback and scoped upstream
correction for only the affected hosts, with rollback/checkpoint and public
endpoint validation. BMC/Appsmith/port `20120`, n8n, DB, Stroyremont, unrelated
services, and client code remain excluded.

