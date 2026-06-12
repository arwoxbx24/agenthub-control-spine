---
artifact_id: universal-microservice-self-healing-runbook
artifact_type: runbook
owner_role: T2 Runtime Worker / Verifier
source_task: AH-748
run_id: RUN-AGENTHUB-UNIVERSAL-MICROSERVICE-SCOPE-BROKER-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Universal Microservice Self-Healing Runbook

## Flow

1. Bind task and RUN_ID.
2. Build service descriptor.
3. Choose permission lane.
4. Run read-only discovery first.
5. Map dependencies.
6. Select validation profile by `service_kind`.
7. Convert routine blockers into PackFix events.
8. Use the lowest sufficient lane for repair.
9. Capture backup/rollback before mutation.
10. Validate service-specific outcome.
11. Write receipt.
12. Move YouTrack only after evidence exists.

## Universal Validation Layers

- L0 inventory: service exists, owner/task/run identified, dependencies mapped.
- L1 runtime: process/container/systemd/worker state, restart count, crash-loop, redacted recent errors.
- L2 local endpoint: content type, latency, health endpoint, no critical 5xx.
- L3 public route: DNS, TLS, redirects, proxy route, external path.
- L4 assets/API: static assets, APIs, CORS/base URL/auth path, websocket/SSE/queue when required.
- L5 browser/user outcome: screenshot, DOM, console, network, visible claim.
- L6 product-specific outcome: read-only business scenario.
- L7 dependencies: upstream/downstream, auth/session redacted, DB/cache/queue availability.
- L8 closure: evidence, receipt, YouTrack stage, no open routine PackFix.

## Lane Safety

Lane 6 operations require explicit owner approval or pre-approved emergency authority. No PackFix can bypass Lane 6.

## Final Rule

If evidence is weak, keep task active and record exact blocker. Do not create chat loops or fake green.
