---
artifact_id: p0-t0-boundary-violation-multi-agent-runaway-20260527
artifact_type: incident_report
owner_role: T0 Control / T1 Architect / Registrar / Verifier
source_task: AH-590
run_id: RUN-P0-T0-HARD-STOP-ISOLATION-20260527
created_at: 2026-05-27
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P0 T0 Boundary Violation and Multi-Agent Runaway Incident

## Incident Class

`AGENTHUB_SYSTEM_PROCESS + CONTROL_SPINE_REGISTRAR + INCIDENT_CORRECTION + YOUTRACK_TASK_SERVICE`

## Owner Evidence Normalization

The owner reported a recurring control-plane failure class:

- T0/TeamLead performed or appeared to perform direct Linux, code, Docker, or
  runtime work.
- Outputs from unrelated agents, products, and sessions were mixed together.
- Task cards multiplied while existing cards did not reliably close.
- Reports were expected in `arwoxbx24/agenthub-control-spine`, but reporting
  and register coverage were delayed or inconsistent.
- Intermediate technical chatter appeared in owner chat instead of backend
  evidence stores.

## Current Baseline Readback

Read set:

- `AGENTS.md`
- `INDEX.md`
- `ARTIFACT_REGISTER.md`
- `PR_QUEUE_REGISTER.md`
- `context/agenthub-current-context-pack.md`
- YouTrack `AH-590`, `AH-570`, `AH-554`

Existing controls already merged before this corrective package:

- AH-570 / PR #52: permission profile, validator, core versioning, policy
  install controls, and runtime path receipts.
- AH-554 / PR #55: T0 live-root hard-enforcement addendum and negative-test
  readback.
- AH-590 / PR #63: backend-only owner communication, role permission profiles,
  model routing, resume lifecycle, methodology router, schemas, runbook, and
  regression suite.
- AH-574 / PR #66: Komodo local baseline receipt, proving the need to keep
  domain/runtime tasks isolated from AgentHub-core governance closure.

## Gap

The previous controls existed, but the owner-facing failure recurred as an
operational integration gap: agents still needed a single compact corrective
package that binds T0 hard-stop, multi-agent isolation, repo-first reporting,
task-debt handling, and backend-only communication into one current incident
artifact set.

## Corrective Scope

This package is governance/control-spine only:

- no Docker mutation;
- no NPM/proxy mutation;
- no DB mutation;
- no firewall/DNS/SSL mutation;
- no product/client code mutation;
- no runtime service repair;
- no broad task closure.

## Task-Debt Classification

Active scope families must stay separated:

- AgentHub core/control-plane: AH-570/AH-590 lineage.
- Live runtime route and Docker/NPM policy: AH-554/AH-572 lineage.
- Komodo: AH-571/AH-574/AH-575/AH-576/AH-577/AH-579 lineage.
- VPN/Hiddify/MTProxy: AH-569 lineage.
- Other product domains such as Appsmith, Dolibarr, Stroyremont, BMC, and site
  monitoring require their own scope signatures and must not be closed by this
  AgentHub-core incident.

## Required Durable Controls

This incident adds or updates:

- `governance/policies/t0-direct-action-hard-stop-policy.md`
- `governance/policies/backend-only-owner-communication-policy.md`
- `schemas/agent-run-isolation.schema.json`
- `evals/t0-hard-stop-negative-tests.md`
- `reports/receipts/P0-t0-hard-stop-multi-agent-isolation-receipt-20260527.md`
- `reports/receipts/P0-task-debt-consolidation-receipt-20260527.md`

## Final Gate

This package can close only as repository governance evidence unless current
runtime readback proves every hard-stop path is installed. If runtime readback
later contradicts the prior installed evidence, the terminal blocker is
`T0_PRETOOL_HARD_STOP_NOT_INSTALLED`.
