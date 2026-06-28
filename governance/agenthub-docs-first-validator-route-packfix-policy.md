---
artifact_id: agenthub-docs-first-validator-route-packfix-policy
artifact_type: active_policy
owner_role: T1 Architecture Broker / Verifier
source_task: AH-763
run_id: RUN-AGENTHUB-DOCS-FIRST-VALIDATOR-ROUTE-PACKFIX-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# AgentHub Docs-First, Validator Route PackFix Policy

## Scope

This policy governs AH-763 for:

- documentation-first validation before any product behavior claims,
- task-bound authority-gated validator execution,
- same-RUN PackFix conversion,
- and model truth checks that cannot be satisfied by requested/resolved/env-only claims.

## Official Fact Base

The following official docs must be required and tracked as sources in every packet:

- `https://developers.openai.com/codex/cli/reference`
- `https://developers.openai.com/codex/config-basic`
- `https://developers.openai.com/codex/agent-approvals-security`
- `https://modelcontextprotocol.io/docs/tutorials/security/authorization`
- `https://modelcontextprotocol.io/specification/2025-11-25/server/tools`
- `https://www.jetbrains.com/help/youtrack/devportal/youtrack-rest-api.html`
- `https://www.jetbrains.com/help/youtrack/devportal/resource-api-commands.html`

## Core requirements

1. No product behavior claim is accepted without official docs packet proof.
2. Any validator execution in this scope must use a task-bound authority envelope.
3. Routine blockers must convert to PackFix events and route through same-RUN repair.
4. Final states must not depend on `requested_model`, `resolved_model`, or
   env-only model claims.
5. Same-gate retry is hard-capped; identical routine blocker repeats escalate
   after the second hit and do not continue to a third PackFix retry.

## Docs packet contract

For any task-behavior claim, the docs packet must include:

- `packet_id`, `task_id`, `run_id`, `scope_signature`, and `task_scope`
- official source list with required URLs and `verified=true`
- `coverage_map.openai_cli_reference`
- `coverage_map.openai_config_basic`
- `coverage_map.openai_approvals_security`
- `coverage_map.mcp_authorization`
- `coverage_map.mcp_tools_spec`
- `coverage_map.youtrack_rest_api`
- `coverage_map.youtrack_commands`

Missing packet or unverified references is a blocker.

## Validator execution authority contract

Validator execution requires all of:

- task-bound `run_id`/`task_id`
- validator identity and path
- `execution_route` and `route_lane`
- `decision` in:
  - `ALLOW`,
  - `ALLOW_WITH_SCOPED_WORKER`,
  - `DENY_FORBIDDEN_SCOPE`,
  - `PACKFIX_REQUIRED`,
  - `ROUTE_REPAIR_REQUIRED`
- no unresolved `T0_DIRECT_AUTHORSHIP_DEFECT`
- no unresolved `DISPATCH_TASK_GATE_MISSING`
- no unresolved `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`
- no unresolved `YOUTRACK_READBACK_PERMISSION_MISSING`
- no unresolved `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`
- no unresolved `GITHUB_CONNECTOR_WRITE_UNAVAILABLE`
- no unresolved `CODEX_USAGE_AUDIT_ACCESS_MISSING`
- no unresolved `MODEL_FALLBACK_RECEIPT_MISSING`
- no unresolved `VALIDATOR_EXECUTION_NOT_RUN`

Known blockers for PackFix conversion:

- `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`
- `DISPATCH_TASK_GATE_MISSING`
- `VALIDATOR_EXECUTION_NOT_RUN`
- `CODEX_USAGE_AUDIT_ACCESS_MISSING`
- `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED`
- `GITHUB_CONNECTOR_WRITE_UNAVAILABLE`
- `T0_DIRECT_AUTHORSHIP_DEFECT`
- `YOUTRACK_READBACK_PERMISSION_MISSING`
- `MODEL_FALLBACK_RECEIPT_MISSING`

## PackFix conversion and retry policy

Same-blocker behavior for this scope:

- first occurrence -> `PACKFIX_REQUIRED`
- second occurrence -> `ROUTE_REPAIR_REQUIRED`
- third occurrence -> hard stop; no third PackFix retry is allowed

## Model truth and finalization gates

YouTrack Done is blocked unless all are true:

- docs packet evidence is present and verified
- authority route execution is task-bound
- model truth status is `PROVEN` or `FALLBACK_PROVEN` when model execution
  is claimed; otherwise the receipt must explicitly record `NO_MODEL_CLAIM`
- usage-audit access is not the only proof path
- all new artifacts are in `INDEX.md`, `ARTIFACT_REGISTER.md`, and
  `PR_QUEUE_REGISTER.md`
- no active routine blocker remains in this RUN
