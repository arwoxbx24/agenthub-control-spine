---
artifact_id: teamlead-ah513-ah518-control-20260523
artifact_type: coordination-report
owner_role: T0 Control Plane
source_task: AH-513/AH-518
run_id: RUN-teamlead-ah513-ah518-control-20260523
worker_window: cdx-NPM-docker
worker_expected_scope: AH-513 and AH-518 Proxy Manager / Docker partner addressing only
created_at: 2026-05-23
status: blocked
primary_blocker: WORKER_SCOPE_DRIFT_TELEGRAM_MTPROXY
default_load: false
safe_to_replay: false
---

# TeamLead AH-513/AH-518 Control Report

## Control Scope

This report records the T0 control-plane window `cdx-teamlead`.

T0 did not implement and did not touch Docker, Proxy Manager, Linux runtime,
Railway, VPN, ports, firewall, database, object storage, secrets, product code,
or live service configuration.

## Required Isolation

| Role | Window | RUN_ID | Scope |
|---|---|---|---|
| TeamLead/T0 | `cdx-teamlead` | `RUN-teamlead-ah513-ah518-control-20260523` | control, routing, evidence review, repo reporting |
| Scoped worker | `cdx-NPM-docker` | not accepted from MTProxy report | AH-513/AH-518 Proxy Manager and Docker partner addressing only |

T0 did not reuse a worker implementation RUN_ID and did not create a second
implementation worker.

## Source Readback

- Canonical repo confirmed: `arwoxbx24/agenthub-control-spine`.
- Forbidden personal owner `arwoxb24` was not used as canonical.
- `AGENTS.md` read.
- `INDEX.md` read.
- `ARTIFACT_REGISTER.md`: not present on `main` at read time.
- Current context pack/baseline: not present on `main` at read time.
- YouTrack `AH-513` read.
- YouTrack `AH-518` read.

## YouTrack Readback

### AH-513

- Summary: architecture for safe standardization of proxy-manager/docker-partner
  addressing without VPN.
- Stage: `Develop`.
- Done gate: not complete for live implementation.
- Evidence says parent contour corrected, but actual Proxy Manager Destination
  values still show IP rows.
- Blocker text says direct Linux/T0 work is forbidden.

### AH-518

- Summary: gated live implementation brief for Docker DNS or host alias transition.
- Stage: `Develop`.
- Current truth: user-visible NPM table still contains IP rows.
- Done gate: not applied; live implementation is not Done.
- Blocker text: AgentHub live worker/API broker route required before NPM auth,
  backup, one-row canary, validation, and rollback proof.

## Worker Evidence Review

Expected worker surface:

- AH-513 and AH-518 only.
- Proxy Manager / Docker / partner addressing.
- IP-to-domain or local-route architecture.
- No VPN unless issue evidence explicitly requires it.
- No Telegram MTProxy classification.

Repository evidence found:

- `reports/devops/mtproxy-domain-route-worker-20260523.md`
- `reports/receipts/mtproxy-domain-route-worker-receipt-20260523.md`

Those files use `RUN-proxy-docker-mtproxy-domain-route-20260523`, but their
source task is AH-468 and their scope is Telegram MTProxy. They do not satisfy
AH-513/AH-518 worker evidence.

## Evidence Decision

| Gate | State |
|---|---|
| T0 did not touch runtime/proxy/docker | PASS |
| AH-513 read | PASS |
| AH-518 read | PASS |
| Worker state checked | PASS |
| Worker report for AH-513/AH-518 | FAIL |
| Worker validation for AH-513/AH-518 | FAIL |
| Worker task readback for AH-513/AH-518 Done | FAIL |
| Telegram MTProxy misclassification avoided by T0 | PASS |
| Repository report written | PASS |

## Final State

Status: `BLOCKED`.

Primary blocker: `WORKER_SCOPE_DRIFT_TELEGRAM_MTPROXY`.

Reason: the visible worker artifact is for AH-468 Telegram MTProxy, while the
current required scope is AH-513/AH-518 Proxy Manager / Docker partner addressing.
T0 cannot close AH-513 or AH-518 from that evidence.
