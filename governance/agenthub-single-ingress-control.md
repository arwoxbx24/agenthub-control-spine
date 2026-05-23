---
artifact_id: agenthub-single-ingress-control
artifact_type: governance-control
source_task: AH-507
run_id: AH-507-CONTROL-LOOP-RECOVERY-20260523
status: active
---

# AgentHub Single-Ingress Control

## Control Rule

All AgentHub recovery work for one objective must use one canonical task id and one active run id. A locked run is superseded by one recovery run and is never dispatched again.

## Required Gates

- One task id is bound before dispatch.
- Existing active recovery runs are checked before creating a new run.
- Locked runs cannot be dispatched, retried, or force-continued.
- TeamLead T0 must not perform manual product implementation.
- Railway, proxy, runtime, Docker, database, firewall, port, tunnel, and secret changes require a separate explicit gate.
- Owner-facing progress chatter is not evidence.
- Evidence is required before Done.
- If the product cannot finish because a public ChatGPT endpoint is unavailable, the run returns a typed blocker instead of PASS.

## AH-507 Recovery Binding

- Canonical task: AH-507.
- Superseded run: AH-CHATGPT-APP-BOOTSTRAP-20260523.
- Recovery run: AH-507-CONTROL-LOOP-RECOVERY-20260523.
- Product blocker remains separate from orchestration recovery.
