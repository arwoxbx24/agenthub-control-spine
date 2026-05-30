---
artifact_id: P0-codex-spark-circuit-breaker-full-closure-audit-20260529
artifact_type: audit
owner_role: T1 Architect / Verifier
source_task: AH-601
run_id: RUN-P0-CODEX-SPARK-CIRCUIT-BREAKER-FULL-CLOSURE-20260529
created_at: 2026-05-29
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# P0 Codex Spark Circuit Breaker Full Closure Audit

## Result

final_state: PRIMARY_MODEL_BURN_CIRCUIT_BREAKER_ACTIVE_TERMINAL

The control-spine route now contains a primary-model burn circuit breaker for
code/config/YAML/shell/programming work. The breaker rejects GPT-5.5/main/base/
primary code authorship before implementation dispatch and requires Codex/Spark
worker routing with same-RUN Spark-unavailability proof for fallback.

## Evidence

- containment run: `RUN-P0-CODEX-SPARK-CIRCUIT-BREAKER-FULL-CLOSURE-20260529`
- containment worker: `W-circuit-breaker-containment-evidence-01`
- containment merge: SUCCESS
- active non-Codex code dispatches: none reported by AgentHub process inventory
- circuit breaker install path: `validators/model_token_router_validator.rb`
- eval fixture path: `evals/model-token-routing/fixtures.json`
- policy path: `governance/model-token-routing-policy.md`

Existing Spark local invocation proof is attached from PR #102:

- proof source: `codex_cli_json_usage_receipt`
- requested model: `gpt-5.3-codex-spark`
- usage tokens: input `27158`, output `823`
- proof artifact hash:
  `e397568b10627f09cc6cd9cc08bce42df832d588084f2538bb6318ec92ee4165`
- event receipt hash:
  `aeb18747b7a092eb1b5902e846e95bfefd1eafafd29061b9ff23db094f54ac52`

## Verifier Boundary

The local Codex JSON usage receipt proves a bounded Codex CLI invocation, but it
does not override the owner-visible subscription meter if that platform meter
still shows no Spark usage delta. In that case the terminal blocker is:

`NON_BLOCKING_PLATFORM_METER_OBSERVATION`

## Controls Installed

- Primary/main/base model code authorship denied for code/config surfaces.
- T0 code/command authorship remains denied.
- GPT-5.5/main/base fallback for code/config proof is denied.
- Non-Spark Codex fallback requires same-RUN Spark-unavailability proof.
- Command-request/self-report proof remains rejected.
- Zero-usage JSON receipts remain rejected.
- Fallback JSON receipts cannot close Spark proof.
- Same-gate failure stops after two attempts.
