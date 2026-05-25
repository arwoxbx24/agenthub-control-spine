---
artifact_id: AGENTHUB-P0-break-glass-safe-route-recovery-final-receipt-20260525
artifact_type: final-route-recovery-receipt
owner_role: Registrar / T1 Route Architect / T2 Worker / Verifier
source_task: AH-567 / AH-536 / AH-554
run_id: RUN-agenthub-p0-break-glass-safe-route-20260525
created_at: 2026-05-25
status: blocked-by-edge-npm-auth
lifecycle: operational_receipt
default_load: false
safe_to_replay: false
---

# P0 Break-Glass Safe Route Recovery Final Receipt

## Result

The report-only/freeze loop was broken for this incident. A break-glass AgentHub
command-worker route was activated and one scoped T2 live worker ran through
AgentHub. Runtime Done is not claimed because the public endpoint matrix still
has active `502` responses.

## Route Repair Evidence

- Start route RUN_ID: `RUN-agenthub-p0-break-glass-safe-route-20260525`
- T1 worker: `T1-break-glass-route-architect-01`
- Route allowlist backup: `@runtime/agent-hub-v2/command-worker-allowed-runs.json.bak-break-glass-20260525`
- Route allowlist change: added `RUN-agenthub-p0-break-glass-safe-route-20260525`
  for the break-glass contract scope.
- First run merge status: `BLOCKED` because it also recorded the stale
  contract-only command dispatch attempt before the emergency route continuation.
- Continuation reason: AgentHub v2 run model closes a run after one worker; the
  T2 worker required a separate emergency worker-route run, without a new task,
  PR, or branch.

## T2 Worker Evidence

- T2 RUN_ID: `agenthub-emergency-worker-route-unblock-ah536-ah554-20260525-2`
- T2 worker: `T2-codex-live-worker-ah536-ah554-01`
- T2 merge status: `SUCCESS`
- T2 output: `@agenthub-runs/agenthub-emergency-worker-route-unblock-ah536-ah554-20260525-2/t2-live-worker-evidence.json`
- T2 output sha256: `e5ce5db930be4e6dc6ee90e1e06d0dd76e4ae23a2312d1ac19eb1aa2adf807c1`
- T2 merge ledger sha256: `6443683d65e9da926f78e2c57b9c65403b93d67741a034f19b1bb10cb09012d0`

T2 safe action result:

- Public matrix before and after remained unchanged.
- `dash.b244.ru` and `yt.b244.ru` returned `200`.
- `port`, `minio-admin`, `git`, `yubikey-v1`, `yubikey-v2`, `transcribe`,
  `dev.transcribe`, `pdf-generator`, `vphdffy`, `arwox`, and `kpd` remained
  `502`.
- Accessible Docker surface did not contain the expected in-scope container
  names in the allowlist.
- No container was started.
- No NPM/edge mutation was performed.
- No DB mutation was performed.
- No BMC/Appsmith/n8n/Stroyremont/client-code mutation was performed.
- No secrets or raw environment values were dumped.

## Verifier Evidence

- Verifier RUN_ID: `agenthub-emergency-worker-route-unblock-ah536-ah554-verifier-20260525`
- Verifier worker: `VERIFIER-break-glass-ah536-ah554-01`
- Verifier output: `@agenthub-runs/agenthub-emergency-worker-route-unblock-ah536-ah554-verifier-20260525/verifier-endpoint-evidence.txt`
- Verifier output sha256: `6e5c347fe5abddcae7ee1d4d4d136a85c0695c201d547052d717b06425c53d77`
- Verifier merge status: `BLOCKED` because public user outcome still has active
  `502` responses.

Verifier public matrix:

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

## Final Gate

| Gate | Verdict |
|---|---|
| Death-loop stopped | PASS |
| T0 remained control-only for runtime | PASS |
| T1 route repair attempted | PASS |
| T2 ran through AgentHub | PASS |
| Forbidden contours untouched | PASS |
| Repository receipt exists | PASS after commit |
| YouTrack readback | PASS after update |
| Public user outcome | FAIL |

## Final Blocker

`EDGE_NPM_AUTH_REQUIRED`

Exact missing item: an authenticated, task-bound edge/NPM configuration route
for the affected AH-536/AH-554 proxy hosts. The safe AgentHub T2 path can run,
but public `502` remains and the required upstream/proxy mapping cannot be read
or corrected from the currently available route. BMC/Appsmith/port `20120`,
n8n, DB, and unrelated services remain excluded.

