---
artifact_id: agenthub-universal-infrastructure-scope-broker-policy
artifact_type: governance_policy
source_task: AH-772
run_id: RUN-AGENTHUB-UNIVERSAL-INFRASTRUCTURE-SCOPE-BROKER-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Universal Infrastructure Scope Broker Policy

## Purpose

This policy controls AgentHub infrastructure and microservice work across Linux commands, Docker, Docker Compose, containers, volumes, networks, proxies, APIs, UIs, schedulers, task services, validators, registrars, and model routers.

It is universal. It must not hardcode one service as the global model. Any global control that depends on one service name fails with `SERVICE_SPECIFIC_POLICY_LEAK`.

## Contour Requirements

Every actionable infrastructure contour must bind:

- one controlling YouTrack task;
- one RUN_ID;
- one project root or explicit service set;
- one scope descriptor;
- one authority envelope;
- one evidence ledger;
- one final Done gate.

## Universal Descriptor Fields

Before action, normalize each component into:

- `service_id`
- `human_name`
- `project_root`
- `component_type`
- `runtime_kind`
- `deployment_kind`
- `official_docs_url`
- `local_guide_path`
- `task_id`
- `run_id`
- `repo`
- `branch`
- `vcs_reference`
- `owner_task_stage`
- `data_surface`
- `secret_handle_refs`
- `auth_surface`
- `network_surface`
- `ui_surface`
- `health_surface`
- `rollback_surface`
- `allowed_operations`
- `forbidden_operations`
- `required_evidence`

## Lanes

- Lane 0: read, inventory, official docs, redacted config metadata.
- Lane 1: repository artifacts, schemas, validators, fixtures, registers, receipts.
- Lane 2: validators and read-only tests.
- Lane 3: sandbox or rehearsal.
- Lane 4: live read-only diagnosis.
- Lane 5: scoped reversible live repair.
- Lane 6: controlled destructive or state mutation with backup, exact target, rollback, and approval where irreversible.
- Lane 7: owner-only irreversible gate.

## PackFix Conversion

Routine platform blockers must become same-RUN PackFix events while a safe autonomous repair path exists. Generic blockers such as missing validator route, missing register append route, missing service descriptor, missing local guide, missing docs packet, missing browser proof, missing model-truth probe, missing task id injection, or missing live-read authority must not be final chat blockers.

After two identical PackFix failures, create an architecture repair PackFix. Do not retry the same gate a third time.

## Secret Handling

Agents must not ask for credentials first. They must check approved secret-handle metadata, deployment metadata names, official docs auth paths, supported recovery routes, and redacted auth probes before owner chat. Raw secrets, env dumps, keys, tokens, and reusable credentials must never be printed or stored in Git.

## Sandbox And Live Mutation

Use sandbox or rehearsal before live mutation when technically feasible. Docker Compose sandboxes must use isolated project names, optional profiles, non-conflicting ports, health checks where available, and no live volume sharing except explicit read-only scope.

## Evidence Quality

HTTP 200 is transport proof only. HTML shell is shell proof only. UI Done requires browser-visible user outcome proof. API Done requires functional API contract proof. Docker/service Done requires service health plus component-specific proof. Task Done requires YouTrack readback.

## Done Gate

Done requires task readback, docs packet, descriptor, authority envelope, PackFix ledger, validation output, VCS binding for repository work, receipt, no fake Done, and no service-specific global policy leak.