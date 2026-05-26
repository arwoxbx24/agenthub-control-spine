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

The approved corrected contract reclassifies the downstream implementation as
`DEVOPS_INCIDENT / DOMAIN_TASK_REFERENCE` with a T2 worker under the AgentHub
Lifecycle Controller. This repository package remains the domain-reference
source for that T2 execution route.

## Work Breakdown

| Task | Layer | Owner | Output | Done Gate |
|---|---|---|---|---|
| `AH-572` | Audit | DevOps read-only worker | Redacted inventory of containers, compose files, networks, NPM upstreams, source ledger | Actual state known; no live mutation |
| `AH-573` | Architecture | Architecture worker | Audit-first daemon/network order, `edge`/internal network contract, alias policy, exception policy | Contract indexed in report |
| `AH-574` | Platform bootstrap | Komodo worker | Core on `edge` + `komodo-internal`; Periphery private/outbound only; official v2 onboarding | No host-published Core/Periphery; no secrets committed |
| `AH-575` | Microarchitecture | Compose worker | Per-service migration templates and service matrix | Templates cover public, internal, DB, worker, exception cases |
| `AH-576` | Edge routing | NPM API worker | IP-upstream and duplicate-upstream cleanup plan | No NPM change without authorized API/readback |
| `AH-577` | Automation | Automation worker | Procedure/alerting design | No restart loop; alert and stop conditions defined |
| `AH-578` | Runtime policy | Runtime safety worker | Resource/logging/daemon preflight policy | Daemon restart gated by rollback and maintenance window |
| `AH-579` | Validation | QA worker | Rollout/rollback/acceptance matrix | Every live acceptance claim has evidence class |
| `AH-580` | Repository package | Repo worker | Report, decomposition, receipt, index/register/PR queue updates | Git diff, commit, and readback evidence |

## Approved Execution Phases

1. Phase 0: verify tasks, sources, PR state, and duplicate absence.
2. Phase 1: read-only live audit only.
3. Phase 2: risk and rollback gate before any mutation.
4. Phase 3: Docker daemon / network decision; create `edge` only after checks.
5. Phase 4: Komodo baseline using official v2 docs and corrected topology.
6. Phase 5: service migration one service at a time.
7. Phase 6: procedures and alerts after stable baseline.
8. Phase 7: resource limits verified by runtime evidence.
9. Phase 8: close loop with typed final state and no secret leakage.

## Architecture Tasks

### A1. Edge Network Contract

Define `edge` as the only shared ingress network. NPM and public services join
it. Databases and internal workers do not join it unless explicitly justified.

Acceptance:

- daemon/network decision is audit-first;
- `edge` is external and created only after conflict checks;
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
- Core is on `edge` plus private `komodo-internal`.
- Periphery is not on public `edge`; it shares private connectivity with Core
  or uses the official outbound mode.
- Periphery Docker socket risk is documented and not marked read-only unless
  runtime tests prove full management still works.

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
- documented legacy exceptions such as Portainer `9443` or VPN host networking
  are allowed until separate migration/exception tasks resolve them.

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
- duplicate-looking upstreams classified by domain evidence before deletion;
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
- No Coolify/Dokploy/Kubernetes replacement path unless a later explicit
  architecture decision supersedes Komodo.

## Typed Blockers

- `TASK_STATE_BLOCKER`
- `INSTRUCTION_SOURCE_DRIFT`
- `MISSING_SERVER_ACCESS`
- `MISSING_NPM_ADMIN_ACCESS`
- `ROLLBACK_EVIDENCE_BLOCKER`
- `OWNER_ONLY_DOCKER_DAEMON_RESTART_GATE`
- `VPN_HOST_NETWORK_EXCEPTION`
- `OFFLINE_SERVICE_ROOT_CAUSE_BLOCKER`
- `RESOURCE_LIMIT_ENFORCEMENT_BLOCKER`
- `ACCEPTANCE_EVIDENCE_BLOCKER`

## ChatGPT Review Checklist

When reviewing this package through GitHub, ChatGPT should verify:

- the report separates proven Docker mechanics from unproven live state;
- Komodo official compose defaults were corrected for this architecture;
- Periphery/Docker socket risk is explicit;
- live rollout is blocked until actual audit evidence exists;
- task graph has parent and bounded child tasks;
- no secrets, raw URLs, or live config dumps are stored.
