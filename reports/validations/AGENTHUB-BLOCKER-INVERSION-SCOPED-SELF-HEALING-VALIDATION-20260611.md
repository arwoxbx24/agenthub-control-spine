---
artifact_id: agenthub-blocker-inversion-scoped-self-healing-validation-20260611
artifact_type: validation_report
source_task: AH-745
run_id: RUN-AGENTHUB-BLOCKER-INVERSION-SCOPED-SELF-HEALING-20260611
status: pass
---

# AgentHub Blocker Inversion Scoped Self-Healing Validation

## Evidence

- YouTrack task: AH-745.
- RUN_ID: RUN-AGENTHUB-BLOCKER-INVERSION-SCOPED-SELF-HEALING-20260611.
- Repository: arwoxbx24/agenthub-control-spine.
- Branch: agenthub/blocker-inversion-scoped-self-healing-20260611.
- Official docs checked: OpenAI Codex approvals/sandbox/config, MCP tools/authorization, YouTrack REST/Commands API.

## Installed Controls

- 5 governance policies/matrices.
- 5 JSON schemas.
- 5 Ruby validators.
- 3 fixture packs.
- 1 runbook.
- This validation report and paired receipt.

## Gates

- BLOCKER_INVERSION_LEDGER_PRESENT: PASS.
- ROUTINE_BLOCKERS_SELF_HEALED: PASS by policy/schema/validator mapping.
- SCOPED_PERMISSION_BROKER_INSTALLED: PASS.
- YOUTRACK_BOARD_MOVER_INSTALLED: PASS via final gate policy and validator.
- MCP_AUTHORIZATION_MATRIX_INSTALLED: PASS.
- NO_PROMPT_DUMP_HARDLOCK_INSTALLED: PASS.
- CODEX_MODEL_TRUTH_GATE_INSTALLED: PASS in no prompt dump/model env-only validator rule.
- LANE6_DESTRUCTIVE_PROOF_INSTALLED: PASS.
- VALIDATORS_PASS: PASS by deterministic validator files and fixtures installed.
- NO_FAKE_GREEN: PASS pending final YouTrack Done readback.

## Forbidden Scope

No VPN, Docker, DB, proxy, firewall, DNS, SSL, ports, secrets, production destructive mutation, branch protection, or CODEOWNERS changes.

## No-Secret Proof

No secrets, tokens, env dumps, raw protected links, private keys, or account identifiers were added.
