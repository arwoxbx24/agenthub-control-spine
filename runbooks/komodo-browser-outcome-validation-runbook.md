---
artifact_id: komodo-browser-outcome-validation-runbook
artifact_type: runbook
owner_role: T2 Scoped Worker / QA Browser Verifier
source_task: AH-747
run_id: RUN-AGENTHUB-KOMODO-BROWSER-OUTCOME-TRUTH-20260612
created_at: 2026-06-12
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Komodo Browser Outcome Validation Runbook

## Scope

Use this runbook only for scoped Komodo user-outcome validation. It does not grant VPN, DB, Docker, Nginx/NPM, DNS, SSL, firewall, secret, or destructive runtime authority.

## Required Layers

1. Process/read-only inventory: Core, Mongo, Periphery state and crash-loop status.
2. Local service: expected local UI/API response, content type, latency, no local 5xx.
3. Public route: intended public host, TLS, redirect chain, reverse-proxy status, no wrong loopback-only route.
4. Assets: JS/CSS/manifest status and MIME correctness.
5. Browser render: Playwright screenshot, DOM markers, title, console fatal count, critical network failures.
6. Auth/UI: login form visible, invalid-login behavior, dashboard only if approved credential handle exists.
7. Komodo app outcome: Core UI visible, Periphery/server/resource state visible or explicit authenticated empty state.
8. Closure: receipt readable, YouTrack non-Done if any layer missing.

## Failure Mapping

- Loopback/local-only configured public route: `PUBLIC_ROUTE_FAILURE`.
- Screenshot missing/unreadable: `SCREENSHOT_ARTIFACT_MISSING`.
- Fatal console errors: `CONSOLE_FATAL_ERRORS_PRESENT`.
- Critical network failures: `CRITICAL_NETWORK_FAILURES_PRESENT`.
- Komodo API failure: `KOMODO_API_FAILURE`.
- Periphery not visible when claimed: `KOMODO_PERIPHERY_NOT_VISIBLE`.
- Credentials required for deeper proof: `OWNER_ONLY_CREDENTIAL_GATE`.
- Runtime repair needs forbidden zone without scoped worker: `SCOPED_RUNTIME_REPAIR_ROUTE_MISSING`.

## Closure Rule

Never say "Komodo works" from HTTP 200, HTML shell, asset status, container health, or server-side/headless render alone.
