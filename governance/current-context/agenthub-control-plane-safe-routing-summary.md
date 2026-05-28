---
artifact_id: agenthub-control-plane-safe-routing-summary
artifact_type: current-context-summary
owner_role: T0 Control Plane / Registrar
source_task: AH-590
run_id: RUN-P0-CONTROL-PLANE-DEADLOCK-DURABLE-FIX-20260528
created_at: 2026-05-28
lifecycle_status: active_control
safe_to_replay: false
---

# AgentHub Control-Plane Safe Routing Summary

This compact summary is not a full chat history. It records active routing rules for the current control-plane deadlock scope.

## Active Rules

- T0 may classify, bind tasks, route workers, verify receipts, and publish registrar artifacts.
- T0 must not edit runtime code, run shell mutation, touch Docker/NPM/DB/proxy/firewall/domain/service surfaces, or access secret values.
- T1 may design the fix and define acceptance gates.
- T2 Codex/runtime worker must own code/config/runtime-control changes.
- Verifier must reject sandbox-only proof for runtime/model execution claims.
- Registrar may write reports, receipts, and lifecycle metadata after evidence exists.
- Missing-access blockers must name the exact missing access surface.
- Code/config work cannot be Done without actual model execution proof or an exact model/route blocker.
- Repeated platform blockers must become same-RUN remediation work, not repeated owner-facing messages.
- User-facing output must stay short and must not include secrets, raw commands, logs, host details, sensitive paths, or internal dumps.

## Current Blocker For This Scope

`ROUTE_GATE_BEFORE_MODEL_INVOCATION`

Sandbox evidence exists, but a real T2 Codex/runtime worker with model execution proof is not available through the current route.
