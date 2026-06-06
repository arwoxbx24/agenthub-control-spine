# P0 AgentHub Runtime Hardlock System Architecture Receipt

RUN_ID: `agenthub-runtime-hardlock-system-architecture-20260606`
Task: `AH-675`
Status: `PASS`
Date: `2026-06-06`

## Runtime Controls Installed

- Active Codex hook config: `/root/.codex/hooks.json`
- Hook command: `@runtime/hooks/agenthub_global_runtime_hook.rb`
- Runtime gate: `@runtime/validators/agenthub_global_runtime_gate.rb`
- Runtime policy: `@runtime/policies/agenthub/global_model_router_nochat_t0_hardlock_policy.yaml`
- Runtime fixtures: `@runtime/fixtures/agenthub-global-model-router-nochat-t0-hardlock-cases.json`
- Runtime validator: `@runtime/scripts/validation/agenthub_global_model_router_nochat_t0_hardlock_checks.rb`
- AgentHub contract exposure: `@runtime/templates/agent-hub-v2-contract.yaml`

## Enforcement Result

| Gate | Result |
| --- | --- |
| T0 apply_patch/code mutation denied by hook | PASS |
| T0 runtime mutation denied by runtime gate | PASS |
| Spark-first code/config route policy | PASS |
| Same-RUN model fallback receipt gate | PASS |
| ACTIVE_RUN progress chat block | PASS |
| Duplicate task create denied, existing update allowed | PASS |
| Parent Done with open child denied | PASS |
| Done without YouTrack readback denied | PASS |
| Secret-like output blocked | PASS |
| Repairable blocker self-healing route | PASS |
| FinalReportGuard terminal-only contract | PASS |

## Physical Task Evidence

- Controlling issue: `AH-675`
- Duplicate search: `NO_DUPLICATE`
- Task write/readback: PASS
- Evidence attach through AgentHub MCP task-service: PASS
- Ownership binding: PASS

## Validation

- `ruby -c @runtime/hooks/agenthub_global_runtime_hook.rb`: PASS
- `ruby -c @runtime/validators/agenthub_global_runtime_gate.rb`: PASS
- `ruby @runtime/scripts/validation/run_check.rb agenthub_global_model_router_nochat_t0_hardlock_checks`: PASS
- `ruby @runtime/scripts/validate_runtime.rb`: PASS
- Hook canary `T0 + apply_patch -> T0_DIRECT_AUTHORSHIP_DEFECT`: PASS

## Documentation Proof

- OpenAI Codex non-interactive: official docs confirm `codex exec` streams progress separately and supports final output file capture.
- OpenAI Codex hooks: official docs confirm `PreToolUse`, `PermissionRequest`, `PostToolUse`, `Stop`, and hook limits; wrapper and final guard remain required.
- OpenAI Codex skills: official docs confirm progressive disclosure and repo/user/admin/system skill locations.
- OpenAI Codex models: official docs list `gpt-5.3-codex-spark` as a near-instant real-time coding iteration model.
- YouTrack issue API: official docs used for physical write/readback requirement.

## Residuals

None for the AgentHub core hardlock scope.

This receipt is runtime evidence, not a substitute for runtime enforcement. The runtime hook, gate, policy, fixtures, validators, and task readback above are the enforcement proof.
