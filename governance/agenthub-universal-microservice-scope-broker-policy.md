---
artifact_id: agenthub-universal-microservice-scope-broker-policy
artifact_type: governance_policy
owner_role: T1 Architecture Broker / T2 Runtime Worker / Registrar / Verifier
source_task: AH-748
run_id: RUN-AGENTHUB-UNIVERSAL-MICROSERVICE-SCOPE-BROKER-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Universal Microservice Scope Broker Policy

## Mission

Install one reusable control model for all current and future services. The model is dynamic and descriptor-based. It must not hard-code Komodo or any other service as the global rule.

## Universal Service Descriptor

Every runtime task must first create or read a service descriptor with:

- `service_id`, `service_name`, `service_kind`;
- owner task id and RUN_ID;
- environment;
- entrypoints: public URL, local URL, ports, compose service, container id, systemd unit, process pattern;
- dependencies: upstream, downstream, database, cache, proxy, DNS, TLS, storage, queue;
- safe read surfaces;
- repair surfaces;
- destructive surfaces;
- rollback method;
- validation profile;
- user outcome gate;
- evidence paths;
- current status.

Unknown service kind must route to read-only discovery first.

## Permission Lanes

- Lane 0: artifact/task control. YouTrack, GitHub control-spine, receipts, registers.
- Lane 1: read-only discovery. Inventory, status, redacted logs, process/container/port/route/browser readback.
- Lane 2: non-destructive repair. One scoped restart/reload/cache-clear/route repair with receipt.
- Lane 3: config mutation. Exact surface, backup, diff receipt, rollback, before/after validation.
- Lane 4: service replacement. Linked identity, backup, data ownership, route map, rollback.
- Lane 5: data/DB-adjacent. Default read-only metadata; mutation only with explicit DB/data scope and backup/restore proof.
- Lane 6: destructive/irreversible. Owner-only explicit approval or pre-approved emergency authority.

No self-healing can bypass Lane 6.

## PackFix Rule

Routine failures become same-RUN PackFix events, not owner-facing deadblocks:

- missing task readback or stage movement;
- missing register/index/PR queue coverage;
- missing worker route;
- missing screenshot, DOM, console, network, API, model proof, or permission receipt;
- stale adapter metadata;
- public route failure after backend-only green;
- repeated same-gate output.

PackFix must record source task, RUN_ID, blocker code, root-cause hypothesis, surface, lane, repair action, validation action, rollback action, receipt path, and close condition.

## Done Truth

Never claim Done from HTTP 200, running container, healthy container, HTML shell, env variables, screenshot-only proof, local-only proof for public claim, sandbox-only proof, PR-only proof, or task-created-only proof.

Done requires implementation or repair evidence, service-kind validation, user outcome proof for user-facing surfaces, receipt, YouTrack stage readback, and no unresolved routine PackFix.

## Forbidden Defaults

No broad prune/reset/delete, no secret/env dump, no direct T0 runtime mutation, no global DNS/firewall/SSL mutation, no DB/data mutation, no unrelated service mutation, and no green status from weak evidence.

## Official Docs Ledger

Concrete workers must verify current official documentation for the invoked surface: Docker/Compose, Linux/man pages, Nginx or proxy product, GitHub, YouTrack, MCP, OpenAI Codex, and product vendor docs. Policy installation alone does not authorize those runtime actions.
