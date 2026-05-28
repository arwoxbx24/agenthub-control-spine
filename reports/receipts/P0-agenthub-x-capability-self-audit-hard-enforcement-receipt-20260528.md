---
artifact_id: p0-agenthub-x-capability-self-audit-hard-enforcement-receipt-20260528
artifact_type: operational_receipt
owner_role: Registrar / Verifier
source_task: AH-590
run_id: RUN-P0-AGENTHUB-X-CAPABILITY-HARD-ENFORCEMENT-20260528
created_at: 2026-05-28
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# P0 AgentHub X Capability Self-Audit Hard Enforcement Receipt

## Route

- RUN: `RUN-P0-AGENTHUB-X-CAPABILITY-HARD-ENFORCEMENT-20260528`
- Repository: `arwoxbx24/agenthub-control-spine`
- Task lineage: AH-590 governance/control-spine scope
- MCP route: AgentHub create, dispatch, execute
- Worker evidence: `T1-agenthub-x-capability-audit`

## Implemented Artifacts

- `governance/agenthub-x-capability-matrix.md`
- `governance/adr/ADR-agenthub-x-controlled-capability-matrix-20260528.md`
- `schemas/agenthub-x-capability-matrix.schema.json`
- `schemas/agent-action-request.schema.json`
- `validators/agenthub_action_policy_validator.rb`
- `validators/t0_direct_action_hard_stop.rb`
- `validators/model_token_router_validator.rb`
- `validators/repo_first_receipt_gate.rb`
- `evals/t0-direct-action-negative-tests/fixtures.json`
- `evals/agenthub-x-capability-matrix/matrix.json`
- `evals/agenthub-x-capability-positive-tests/fixtures.json`
- `evals/model-token-routing/fixtures.json`
- `evals/repo-first-reporting/fixtures.json`
- `runbooks/agenthub-x-capability-remediation.md`
- `reports/audits/P0-agenthub-x-capability-self-audit-20260528.md`
- `reports/audits/P0-agenthub-x-self-critique-correction-20260528.md`

## Gate Results

| Gate | Result |
|---|---|
| F1-F8 fact table | PASS |
| Capability matrix artifact | PASS |
| Schema artifacts | PASS |
| T0 hard-stop negative fixtures | PASS |
| Positive route fixtures | PASS |
| Model/token fixtures | PASS |
| Repo-first fixtures | PASS |
| Self-critique report | PASS |
| Secret values printed | false |
| Product/runtime/Docker/NPM/DB/proxy/DNS/firewall mutation | false |
| Runtime hook live activation | NOT_CLAIMED |

## Done Boundary

This receipt supports `DONE_WITH_EVIDENCE` for repository governance/control-
spine enforcement artifacts only. Runtime hook activation remains subject to
future adapter readback; if unavailable, use a typed hook-path blocker instead
of T0 fallback.
