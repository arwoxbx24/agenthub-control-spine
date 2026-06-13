---
artifact_id: linux-final-truth-gate-runbook
artifact_type: runbook
owner_role: T1 Architect / Registrar / Verifier
source_task: AH-790
run_id: linux-final-truth-gate-20260613
created_at: 2026-06-13
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Linux Final Truth Gate Runbook

## Intake

1. Bind one YouTrack task and RUN_ID.
2. Read AGENTS.md, INDEX.md, registers, current context, and active AH-788 controls.
3. Classify user-visible scope.
4. Create or update a Linux-visible claim ledger before final text.

## Evidence Selection

Use only evidence visible from Linux/Codex execution context:

- repository file/diff/main readback;
- validator or test artifact;
- YouTrack readback;
- AgentHub/MCP receipt;
- browser-worker receipt for user-visible behavior;
- service/API artifact for non-UI service scope;
- redaction/security receipt.

Do not use chat text, owner statements, prior assistant drafts, PR body alone, screenshot without route/story, or local-only status for user-visible work.

## Validation

Run `validators/final_truth_gate_validator.rb fixtures/final-truth-gate/fixtures.json` when local checkout exists. If no local checkout exists, perform repository readback and record validator execution as blocked by `REPO_LOCAL_CHECKOUT_UNAVAILABLE`; do not claim executed validator.

## PackFix

Routine missing browser route, validator route, parser marker, register row, PR queue row, readback artifact, unsupported claim, stale report conflict, or duplicate PR tail becomes same-RUN PackFix.

## Closure

Stage Done requires:

- Implementation evidence;
- Validation evidence;
- Receipt;
- Blocker: none;
- YouTrack readback after update;
- no pending/residual text;
- final answer generated only from green ledger claims.
