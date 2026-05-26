---
artifact_id: komodo-orchestration-roadmap-20260526
artifact_type: devops-architecture-report
owner_role: T1 Architecture Broker
source_task: AH-571
run_id: RUN-komodo-orchestration-20260526
created_at: 2026-05-26
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# Komodo / NPM / Portainer Docker Orchestration Roadmap

## Scope

This report analyzes the Claude-authored proposal to add Komodo as the Docker
orchestration layer for an existing single-server estate with Nginx Proxy
Manager (NPM) and Portainer already running.

This document is repository-only planning evidence. It did not inspect or
change live Docker, NPM, Portainer, database, firewall, DNS, SSL, or runtime
state.

## Source Ledger

Validated source references:

- Komodo setup overview: https://komo.do/docs/setup
- Komodo MongoDB setup and official compose flow: https://komo.do/docs/setup/mongo
- Komodo server connection / Periphery model: https://komo.do/docs/setup/connect-servers
- Komodo Docker Compose Stack resource: https://komo.do/docs/deploy/compose
- Komodo procedures and actions: https://komo.do/docs/automate/procedures
- Official Komodo compose file: https://github.com/moghtech/komodo/blob/main/compose/mongo.compose.yaml
- Docker Compose networking: https://docs.docker.com/compose/how-tos/networking/
- Docker daemon reference: https://docs.docker.com/reference/cli/dockerd/
- Docker local logging driver: https://docs.docker.com/engine/logging/drivers/local/

## Executive Decision

Komodo is the right class of tool for the stated goal: it adds a stack
orchestration layer without replacing NPM as the edge reverse proxy and without
replacing Portainer as the manual inspection panel.

The target architecture should not try to make application containers
auto-select random free host ports. The safer solution is to remove host-port
bindings from public application services and route through Docker DNS names on
a shared external network. In that model only the edge proxy binds public host
ports, while NPM reaches services by stable aliases such as `kutt-server-1` or
future canonical names such as `prod-kutt-server`.

## Approved Corrected Contract

The approved execution contract dated 2026-05-26 supersedes the raw Claude
draft for any future AgentHub/Codex implementation.

Contract identity:

- `TASK_CLASS`: `DEVOPS_INCIDENT / DOMAIN_TASK_REFERENCE`.
- `ROLE`: `T2_WORKER under AgentHub Lifecycle Controller`.
- `METHODOLOGY_PROFILE`: `INCIDENT with STANDARD implementation controls`.
- `SCOPE_SIGNATURE`:
  `komodo_orchestration_npm_edge_dns_aliases_no_random_host_ports_20260526`.

This report remains a domain-reference and review artifact. Live Docker/NPM
work must be executed by a scoped T2 worker with rollback and evidence.

## Architecture Layering

### Layer 1: NPM

NPM remains the only edge ingress for HTTP/HTTPS traffic. It owns domain
routing, certificate automation, and public ports 80/443. The migration must
not replace NPM with Traefik, Caddy, or another bundled reverse proxy.

### Layer 2: Portainer

Portainer remains a manual container inspection and emergency observation
surface. It should not become the stack source of truth once Komodo owns stack
deployment.

### Layer 3: Komodo

Komodo becomes the stack orchestration layer:

- Stack resources deploy Docker Compose projects.
- Stack definitions can come from UI, host files, or Git-backed repos.
- Periphery agents connect managed servers to Core.
- Procedures and actions can orchestrate multi-step workflows and schedules.

## Critical Corrections To The Claude Scenario

1. **Network and daemon order is audit-first.** Do not create `edge` before
   existing Docker networks, host routes, VPN ranges, LAN ranges, and the
   need for `default-address-pools` are checked. If daemon restart is required
   but not authorized, stop with `OWNER_ONLY_DOCKER_DAEMON_RESTART_GATE`.

2. **Official Komodo compose publishes Core by default.** The official
   `mongo.compose.yaml` includes `9120:9120`. For this server architecture that
   must be overridden or removed so Komodo is reachable only through the Docker
   network and NPM.

3. **Core and Periphery topology must be explicit.** Core must attach to
   `edge` for NPM access and to `komodo-internal` for Komodo private traffic.
   Periphery must not attach to public `edge`; it must either share
   `komodo-internal` with Core or use the official outbound connection mode.
   Do not isolate Periphery so Core cannot communicate with it.

4. **Docker socket belongs to Periphery, not Core, in the official compose.**
   The official compose mounts `/var/run/docker.sock` for Periphery. A read-only
   Docker socket is not a safe assumption for deployments because stack
   orchestration needs Docker control operations. This must be handled as a
   high-trust live-worker permission boundary, not as a casual read-only mount.

5. **Periphery v2 auth is not manual Ed25519 keypair work in normal setup.**
   Komodo documentation describes generated public/private key pairs and an
   onboarding-key flow. The implementation plan should use Komodo's current
   onboarding/key-rotation model and avoid inventing manual key distribution.

6. **`daemon.json` changes are live Docker daemon changes.** Updating
   `default-address-pools` and logging defaults may be valid, but it requires a
   maintenance window, rollback file, daemon restart plan, and post-restart
   container readback. It must not be bundled into a casual migration step.

7. **`docker system prune --volumes -f` is risky.** The proposed cleanup says
   "only for stopped containers", but `--volumes` can remove unused volumes.
   The default weekly cleanup procedure must exclude volume deletion unless a
   separate volume-retention audit approves it.

8. **Acceptance must allow documented legacy exceptions.** Portainer `9443`,
   VPN/3x-ui host networking, or other legacy host ports are not automatically
   violations. The correct acceptance is no new random host-port bindings and
   every remaining host-port exception documented with owner, reason, rollback,
   and follow-up migration decision.

9. **Duplicate-looking NPM upstreams are not automatically duplicates.** Two
   domains may legitimately point to the same upstream. Domain-level evidence is
   required before deletion.

10. **IP-based upstreams must be identified before replacement.** For
   `172.17.0.1:3500` and `172.17.0.1:9444`, identify container, domain, owner,
   and current health before changing NPM.

11. **Resource limits require runtime evidence.** YAML presence is not enough;
   verify enforcement through Docker Compose / Docker Engine inspect or stats.

## Target Network Model

### External Edge Network

`edge` is a shared external Docker bridge network. NPM and every public service
join this network. NPM routes to service aliases on this network.

Rules:

- `edge` must exist before Compose projects that reference it are deployed, but
  must be created only after audit and subnet conflict checks pass.
- Public app services use `expose`, not `ports`.
- NPM upstreams must use Docker DNS aliases, not `172.17.0.*`.
- Legacy aliases remain until NPM upstreams are deliberately migrated.
- New canonical aliases use `<env>-<project>-<service>`.

### Internal Project Networks

Each project gets an internal network such as `prod-kutt-internal` or
`dev-transcribe-internal`. Databases, Redis, queues, and internal workers join
only their internal network unless they have a real external route requirement.

### Forbidden Defaults

Forbidden unless a child task proves and documents an exception:

- host-port bindings on app containers;
- static Docker IPs;
- `network_mode: host`;
- NPM upstreams pointing to `172.17.0.*`;
- direct `localhost:<port>` service-to-service calls;
- broad NPM, DB, firewall, or Docker daemon edits by T0.

## Microarchitecture

Each stack should be treated as one deployable unit with:

- one Compose project name;
- one or more public service aliases on `edge`;
- one private internal network;
- explicit healthcheck;
- restart policy;
- resource limits where supported by the deployment mode;
- per-service logging defaults only when daemon-level defaults are insufficient.

Recommended migration shape:

```yaml
services:
  app:
    image: registry.example/app:tag
    expose:
      - "3000"
    networks:
      edge:
        aliases:
          - kutt-server-1
          - prod-kutt-server
      internal: {}
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "curl -fsS http://127.0.0.1:3000/health || exit 1"]
      interval: 10s
      timeout: 3s
      retries: 5
      start_period: 30s

networks:
  edge:
    external: true
    name: edge
  internal:
    name: prod-kutt-internal
    internal: true
```

If an image lacks `curl` or `wget`, the healthcheck must be adapted to tools
actually present in the image or moved to an external blackbox check.

## Programmatic Work

Implementation work splits into these programmatic surfaces:

1. Compose normalization: remove `ports`, add `expose`, attach networks, add
   aliases, add healthchecks, add restart policy.
2. Komodo stack onboarding: import existing compose projects by project name,
   or register Git-backed stack definitions.
3. NPM upstream cleanup: replace IP-based upstreams with aliases after the
   target container is attached to `edge`.
4. Procedure automation: add restart/alert procedures only after healthcheck
   behavior is proven.
5. Validation scripts: produce read-only checks for host-port bindings,
   network membership, duplicate upstreams, and IP-based upstreams.

## Implementation Roadmap

Phase 0: task and source gate. Verify `AH-571` and `AH-572`..`AH-580`, repo
registers, PR `#54`, and source precedence.

Phase 1: read-only live audit. Collect Docker, network, Compose, and NPM
inventory without mutation.

Phase 2: risk and rollback gate. Capture rollback snapshots and define rollback
triggers before any write.

Phase 3: Docker daemon / network decision. Decide whether daemon config change
is required; create `edge` only after conflict checks pass.

Phase 4: Komodo baseline. Deploy Core/Periphery from official v2 docs, adjusted
for no public host publish and correct Core/Periphery connectivity.

Phase 5: service migration, one service at a time.

Phase 6: procedures and alerts after baseline plus at least one stable
migration.

Phase 7: resource limits with runtime enforcement evidence.

Phase 8: close loop with YouTrack, PR/register updates, receipt, and one typed
final state.

## Answer To The Port Distribution Question

This architecture solves the global port-conflict problem only if the goal is
reframed correctly.

It will not make containers dynamically "find free host ports" and update
routing magically. That pattern is fragile because NPM and clients still need a
stable target.

It will work better by eliminating random host ports for application services:
containers keep stable internal ports, Docker DNS gives them stable names on
`edge`, and NPM routes to those names. After a server restart, Docker/Compose
recreates containers and reattaches them to declared networks; NPM can still
reach the declared alias if the stack comes back healthy.

The remaining non-automatic parts are:

- the service must actually start;
- the alias must be declared in Compose;
- the network must exist;
- NPM must be attached to the same network;
- NPM must use the alias, not a stale IP or host port;
- special cases such as VPN panels may legitimately require host networking.

Therefore the design is architecturally sound for the reported Docker problem,
but site-specific success is not proven until an authorized worker audits the
actual compose files, NPM upstreams, network modes, and post-restart behavior.

## Acceptance Criteria For Live Rollout

Live rollout is complete only when all of the following are proven:

- NPM remains the only public HTTP/HTTPS edge router on 80/443;
- Portainer and other legacy host-port exceptions are documented instead of
  silently treated as violations;
- app services do not create new `0.0.0.0:<port>` bindings;
- NPM proxy hosts are Online;
- Komodo stacks are Healthy;
- no NPM upstream uses `172.17.0.*`;
- duplicate NPM upstreams are resolved;
- every exception is documented with owner, reason, rollback, and validation;
- restart test confirms services return with the same DNS aliases.

Allowed final states for future execution:

- `DONE_WITH_EVIDENCE`
- `READY_BLOCKED_BY_PLATFORM_GATE`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
- `FORBIDDEN_SCOPE_BLOCKER`
- `INSTRUCTION_SOURCE_DRIFT`
- `WRONG_TASK_CLASS_BLOCKER`
- `SAFETY_QUARANTINE`

Typed blockers:

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

## Risk Matrix

| Risk | Impact | Mitigation |
|---|---:|---|
| Docker subnet conflict | High | Preflight routes/VPN/LAN before `default-address-pools`; do not change daemon without rollback. |
| NPM loses DNS reachability | High | Attach service to `edge` and validate alias before removing host-port fallback. |
| Komodo socket permissions | High | Treat Periphery Docker socket access as high-trust live-worker permission. |
| Healthcheck false negatives | Medium | Adapt healthchecks to each image; do not assume `/health` exists. |
| Volume cleanup data loss | High | Do not use `docker system prune --volumes` in default automation. |
| VPN panel host networking | High | Audit and document exception; migrate last or leave unchanged. |
| Offline services | Medium | Diagnose before migration; do not migrate broken services blindly. |

## Created Task Graph

Parent task:

- `AH-571`: architecture and repository package for Komodo rollout.

Child tasks:

- `AH-572`: read-only live audit and source validation preflight.
- `AH-573`: target network architecture and DNS alias contract.
- `AH-574`: Komodo Core and Periphery bootstrap plan.
- `AH-575`: per-service Compose migration templates.
- `AH-576`: NPM upstream cleanup for IP-based and duplicate routes.
- `AH-577`: healthcheck, alerting, and procedure automation design.
- `AH-578`: resource limits, logging, and daemon preflight policy.
- `AH-579`: rollout, rollback, and acceptance validation matrix.
- `AH-580`: ChatGPT review package in control-spine repository.

## Final Recommendation

Proceed with Komodo as the orchestration layer, but split documentation,
read-only audit, and live rollout into separate controlled tasks. Do not run the
Claude prompt as-is on production. Use it as source material, corrected by this
report, and require a live DevOps worker to prove the actual container/NPM
state before implementation.
