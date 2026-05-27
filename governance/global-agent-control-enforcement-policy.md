---
artifact_id: global-agent-control-enforcement-policy
artifact_type: governance_policy
owner_role: T1 Architect / Registrar
source_task: AH-590
run_id: RUN-P0-GLOBAL-AGENT-CONTROL-SECRETS-REPO-AUDIT-20260527
created_at: 2026-05-27
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Global Agent Control Enforcement Policy

## Decision

T0 is a control-plane role and cannot be an implementation or runtime author. The enforcement surface is not owner chat and not a prompt warning; it is the pre-action policy chain at AgentHub MCP ingress, dispatch/execute adapters, Codex bootstrap, worker launcher, and registrar merge gate.

## Required Action Record

Every action that can change repository, runtime, task, validation, or artifact state must carry:

- `run_id`
- `task_id`
- `actor_role`
- `worker_role`
- `authority_profile`
- `scope_signature`
- `allowed_surfaces`
- `forbidden_surfaces`
- `evidence_path`
- `receipt_path`
- `secret_redaction_gate`

The legacy field `RUN_ID` is accepted only before normalization. The normalizer must emit lowercase `run_id` before schema validation and persistence.

## T0 Deny Classes

When `actor_role=T0_CONTROL`, deny before execution:

- shell or command execution;
- Python, Bash, Node, Ruby, PHP, Go, YC, TWC, NPM, Docker, Compose, systemd, PM2;
- product code/config/YAML/env edits;
- DB, proxy, firewall, DNS, SSL, NPM, runtime, service mutation;
- blind secret search or raw secret read;
- broad log/transcript/file scans.

Required denial code: `BLOCKED_T0_DIRECT_AUTHORSHIP`.

## Allowed T0 Work

T0 may classify, route, open or resume AgentHub RUNs, assign roles, read sanitized control artifacts, verify receipts, update task readback, and send final owner output.

## Loop Breaker

If the same route blocker appears twice for a scope, the third attempt is forbidden. The run must switch to architecture repair or a typed terminal blocker. Cosmetic retry prompts are policy violations.

## Done Gate

`DONE_WITH_EVIDENCE` requires repository receipt, register coverage, YouTrack readback, negative-test proof, secret redaction proof, and no hidden active same-scope blocker.
