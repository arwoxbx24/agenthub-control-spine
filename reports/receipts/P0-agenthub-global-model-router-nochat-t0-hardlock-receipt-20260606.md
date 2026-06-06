# P0 AgentHub Global Model Router / No-Chat / T0 Hardlock Receipt

RUN_ID: `agenthub_global_model_router_nochat_t0_hardlock_20260606`
Task class: `AGENTHUB_SYSTEM_PROCESS / INCIDENT_CORRECTION / CORE_RUNTIME_GOVERNANCE_REPAIR`
Status: `PASS`
Date: `2026-06-06`

## Installed Controls

- Global policy-as-code: `@runtime/policies/agenthub/global_model_router_nochat_t0_hardlock_policy.yaml`
- Runtime gate: `@runtime/validators/agenthub_global_runtime_gate.rb`
- Regression fixtures: `@runtime/fixtures/agenthub-global-model-router-nochat-t0-hardlock-cases.json`
- Runtime validation check: `@runtime/scripts/validation/agenthub_global_model_router_nochat_t0_hardlock_checks.rb`
- AgentHub v2 contract exposure: `@runtime/templates/agent-hub-v2-contract.yaml`
- Contract accessor and MCP contract output: `@runtime/scripts/agent_hub_v2/contract.rb`, `@runtime/scripts/agent_hub_v2.rb`
- Validation runner registration: `@runtime/scripts/validate_runtime.rb`, `@runtime/scripts/validation/run_check.rb`
- Model selector correction: `@runtime/scripts/teamlead_runtime/selector.rb`
- Task-service/MCP readback correction: `@runtime/scripts/agent_hub_v2/core.rb`

## Enforcement Matrix

| Control | Result |
| --- | --- |
| CODE_AUTHORING route class requires Codex-capable worker | PASS |
| DEVOPS_RUNTIME route class requires Codex-capable worker | PASS |
| Spark-first route for code/config/programming work | PASS |
| Same-RUN fallback receipt when Spark is unavailable | PASS |
| T0 direct code/config authorship denial | PASS |
| T0 direct runtime mutation denial | PASS |
| ACTIVE_RUN owner progress chat denial | PASS |
| Duplicate Fact/Action/Left progress denial | PASS |
| Duplicate task creation denial with existing-update allowed | PASS |
| Parent Done with open child denial | PASS |
| Done without physical YouTrack readback denial | PASS |
| Secret-like output denial | PASS |
| Repairable blocker same-RUN self-healing route | PASS |
| Owner-only gate terminal route | PASS |
| Full transcript replay and methodology overload denial | PASS |

## Validation Evidence

- `ruby -c @runtime/validators/agenthub_global_runtime_gate.rb`: PASS
- `ruby -c @runtime/scripts/validation/agenthub_global_model_router_nochat_t0_hardlock_checks.rb`: PASS
- `ruby -c @runtime/scripts/agent_hub_v2/contract.rb`: PASS
- `ruby -c @runtime/scripts/agent_hub_v2.rb`: PASS
- `ruby @runtime/scripts/validation/run_check.rb agenthub_global_model_router_nochat_t0_hardlock_checks`: PASS, 15/15 fixtures
- `ruby @runtime/scripts/validation/run_check.rb plan_launch_checks`: PASS
- `ruby @runtime/scripts/validation/run_check.rb agent_hub_v2_mcp_checks`: PASS
- `ruby @runtime/scripts/validate_runtime.rb`: PASS

## Documentation Anchors

- OpenAI Codex non-interactive output capture: `https://developers.openai.com/codex/noninteractive`
- OpenAI Codex hooks: `https://developers.openai.com/codex/hooks`
- JetBrains YouTrack issue operations: `https://www.jetbrains.com/help/youtrack/devportal/operations-api-issues.html`

## Residuals

None for this installed control package.

Domain services, client projects, PM2, Docker, proxy, firewall, DB, DNS, SSL, cloud billing/quota, object storage, and secrets were not modified.
