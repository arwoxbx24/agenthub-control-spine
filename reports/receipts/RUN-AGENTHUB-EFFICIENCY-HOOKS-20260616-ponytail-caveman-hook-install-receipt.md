---
artifact_id: AGENTHUB-PONYTAIL-CAVEMAN-HOOK-CONTROL
lifecycle: operational_receipt
default_load: false
safe_to_replay: false
source_task: AH-813
run_id: RUN-AGENTHUB-EFFICIENCY-HOOKS-20260616
---

# Ponytail/Caveman Hook Install Receipt

## Routing Receipt

- TASK_CLASS: AGENTHUB_SYSTEM_PROCESS / CONTROL_SPINE_REGISTRAR / CODEX_HOOK_INTEGRATION
- ROLE: T1_ARCHITECT + REGISTRAR + VERIFIER
- source_task: AH-813
- RUN_ID: RUN-AGENTHUB-EFFICIENCY-HOOKS-20260616
- SCOPE_SIGNATURE: install durable AgentHub/Codex hook-level efficiency controls for already-installed Ponytail and Caveman plugins
- mutation_scope: repository-local Codex hook fallback, governance policy, runbook, schema, receipt, index/register rows
- rollback_path: remove AH-813 files/rows listed in the runbook

## Plugin Inventory

- Ponytail: installed from Codex plugin cache, version 4.6.0, source repository DietrichGebert/ponytail.
- Caveman: installed from Codex plugin cache, version 0.1.0, source repository JuliusBrussee/caveman.
- Codex user-level hooks: existing AgentHub runtime gate present for PreToolUse, PermissionRequest, PostToolUse, and Stop.
- Repository fallback hooks: `.codex/hooks.json` adds SessionStart and UserPromptSubmit visible efficiency lines.

## Installed Controls

- `.codex/hooks.json`: visible SessionStart/UserPromptSubmit fallback.
- `governance/AGENTHUB-PONYTAIL-CAVEMAN-HOOK-POLICY.md`: safety hierarchy and minimizer/compressor policy.
- `runbooks/AGENTHUB-PONYTAIL-CAVEMAN-HOOKS-RUNBOOK.md`: verification, rollback, troubleshooting.
- `schemas/agenthub-efficiency-hook-receipt.schema.json`: receipt schema.
- Index/register/PR queue rows updated under AH-813.

## Evidence

- AgentHub MCP route created: RUN-AGENTHUB-EFFICIENCY-HOOKS-20260616.
- Worker dispatch receipt: `mcp-sandbox-dispatch:3f3a836da6029949b225e601`.
- Ownership binding: `agent_hub_mcp:RUN-AGENTHUB-EFFICIENCY-HOOKS-20260616:ownership_bind:PASS`.
- Revision guard: write route allowed on `agenthub/RUN-AGENTHUB-EFFICIENCY-HOOKS-20260616`; rollback branch recorded.
- Official OpenAI docs confirm Codex supports lifecycle hooks from `hooks.json`, including SessionStart and UserPromptSubmit, and supports project-local `.codex/hooks.json` when trusted.
- External plugin source pages checked on GitHub before mutation; benchmark claims are treated as external claims, not local results.

## Validation Status

- Hook JSON syntax: pending local validation command.
- Schema JSON syntax: pending local validation command.
- Fresh-session startup proof: CODEX_HOOK_AUTOACTIVATION_UNCONFIRMED until a new supported Codex session is started from this repository and shows the banner.
- Security/destructive compression proof: policy installed; runtime behavioral proof still required before final Done.
- No project-specific 60-70% measured reduction claimed. Baseline metrics require 5 comparable AgentHub tasks or 10 synthetic tasks.

## Blockers

- CODEX_HOOK_AUTOACTIVATION_UNCONFIRMED
- FRESH_SESSION_PROOF_NOT_RUN

Final Done is not claimed until blockers are closed.
