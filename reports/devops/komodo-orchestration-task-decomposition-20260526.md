---
artifact_id: komodo-orchestration-task-decomposition-20260526
artifact_type: implementation-task-decomposition
owner_role: T1 Architecture Broker
source_task: AH-571
run_id: RUN-komodo-orchestration-20260526
created_at: 2026-05-26
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Komodo Orchestration Implementation Decomposition

## Parent

`AH-571` owns the planning and repository package. It is tracking/documentation
only and must not be used as proof that live Docker/NPM migration is complete.

## Work Breakdown

| Task | Layer | Owner | Output | Done Gate |
|---|---|---|---|---|
| `AH-572` | Audit | DevOps read-only worker | Redacted inventory of containers, compose files, networks, NPM upstreams, source ledger | Actual state known; no live mutation |
| `AH-573` | Architecture | Architecture worker | `edge`/internal network contract, alias policy, exception policy | Contract indexed in report |
| `AH-574` | Platform bootstrap | Komodo worker | Core/Periphery bootstrap plan and secret/key handling | No host-published Core in target compose; no secrets committed |
| `AH-575` | Microarchitecture | Compose worker | Per-service migration templates and service matrix | Templates cover public, internal, DB, worker, exception cases |
| `AH-576` | Edge routing | NPM API worker | IP-upstream and duplicate-upstream cleanup plan | No NPM change without authorized API/readback |
| `AH-577` | Automation | Automation worker | Procedure/alerting design | No restart loop; alert and stop conditions defined |
| `AH-578` | Runtime policy | Runtime safety worker | Resource/logging/daemon preflight policy | Daemon restart gated by rollback and maintenance window |
| `AH-579` | Validation | QA worker | Rollout/rollback/acceptance matrix | Every live acceptance claim has evidence class |
| `AH-580` | Repository package | Repo worker | Report, decomposition, receipt, index/register updates | Git diff, commit, and readback evidence |

## Architecture Tasks

### A1. Edge Network Contract

Define `edge` as the only shared ingress network. NPM and public services join
it. Databases and internal workers do not join it unless explicitly justified.

Acceptance:

- `edge` is external and pre-created.
- Alias naming is documented.
- Legacy alias compatibility is documented.
- Static IP and host networking exceptions require proof.

### A2. NPM Boundary

NPM remains the reverse-proxy and certificate boundary. Komodo does not replace
NPM and must not bind 80/443.

Acceptance:

- NPM is the only planned public HTTP/HTTPS binder.
- NPM upstreams use aliases, not Docker bridge IPs.
- Duplicate upstream cleanup is separately validated.

### A3. Komodo Boundary

Komodo owns Stack deployment and procedures. Portainer remains inspection only.

Acceptance:

- Existing Compose projects are imported by actual project name.
- Git-backed stack model is preferred for future maintainability.
- Periphery Docker socket risk is documented.

## Microarchitecture Tasks

### M1. Compose Template Family

Create templates for:

- public HTTP service;
- public HTTP service plus private DB;
- background worker;
- stateful service;
- exception service.

Acceptance:

- `ports` is absent for normal app services.
- `expose` documents internal ports.
- healthcheck is image-appropriate.
- resource limits are explicit where supported.

### M2. Healthcheck Matrix

Each service needs an endpoint or command that proves readiness. The generic
`/health` assumption is invalid until confirmed per service.

Acceptance:

- healthcheck command uses tools available in the image;
- start period reflects cold-start behavior;
- failed healthcheck does not trigger infinite restart loops.

### M3. Resource And Logging Matrix

Identify heavy services and assign CPU/memory/logging limits.

Acceptance:

- YouTrack, transcribe, MinIO, n8n, and the fifth heavy service are audited;
- log rotation uses Docker local logging defaults or service-level override;
- `docker system prune --volumes` is not default automation.

## Programmatic Tasks

### P1. Read-Only Inventory Scripts

Prepare scripts or commands for:

- host-port inventory;
- compose `ports` scan;
- network mode scan;
- bridge-IP upstream scan;
- duplicate NPM upstream scan.

Acceptance:

- commands are read-only;
- output is redacted before user-facing publication;
- NPM data uses authorized API/export route.

### P2. Migration Worker Contract

Define a worker prompt/contract for one-service migration.

Acceptance:

- one service per change batch;
- rollback checkpoint before edit;
- alias works before host-port fallback is removed;
- post-change checks prove no new host binding.

### P3. Validation Worker Contract

Define final validation evidence:

- Docker ports table;
- network membership;
- NPM Online readback;
- Komodo Healthy readback;
- no duplicate/IP upstreams;
- restart survivability test.

Acceptance:

- no `UNKNOWN`, `PARTIAL`, or `NOT_PROVEN` gate is reported as Done.

## Rollout Order

1. Read-only audit.
2. Low-risk public service migration.
3. URL shortener / Kutt duplicate route cleanup.
4. n8n.
5. MinIO, with console/API split validated.
6. Stroy PHP.
7. Transcribe and dev transcribe.
8. Arwox and KPD proxy.
9. YouTrack.
10. Yubikey services.
11. Offline services only after diagnosis.
12. VPN panel last, with host-network exception if proven.
13. Unknown bridge-IP upstreams after owner identification.

## Non-Goals

- No Kubernetes.
- No replacement of NPM.
- No replacement of Portainer.
- No direct T0 live runtime edits.
- No dynamic host-port allocation as the primary routing model.
- No NPM UI/config/container access without exact authorization.

## ChatGPT Review Checklist

When reviewing this package through GitHub, ChatGPT should verify:

- the report separates proven Docker mechanics from unproven live state;
- Komodo official compose defaults were corrected for this architecture;
- Periphery/Docker socket risk is explicit;
- live rollout is blocked until actual audit evidence exists;
- task graph has parent and bounded child tasks;
- no secrets, raw URLs, or live config dumps are stored.
