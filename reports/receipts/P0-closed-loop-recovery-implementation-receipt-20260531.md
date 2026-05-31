---
artifact_id: p0-closed-loop-recovery-implementation-receipt-20260531
artifact_type: operational_receipt
owner_role: T1_ARCHITECT_LEAD_FOR_AGENTHUB_CORE / T0 Registrar
source_task: AH-P0-CLOSED-LOOP-RECOVERY
run_id: RUN-P0-CLOSED-LOOP-RECOVERY-20260531
created_at: 2026-05-31
safe_to_replay: false
---

# P0 Closed-Loop Recovery Implementation Receipt

final_state: DONE_WITH_EVIDENCE

## Fact Check

Before this run, control-spine already had T0 boundary, model routing,
Codex-native capability, three-component cycle, and artifact/PR queue controls.
It did not have a dedicated closed-loop recovery package with:

- `SPAWNED_WORKER_DISPATCH` schema;
- closed-loop autonomy schema;
- closed-loop recovery validator;
- closed-loop recovery eval fixtures;
- closed-loop worker dispatch prompt;
- architect recovery contract prompt;
- explicit register coverage for this prompt.

This run installed those missing controls.

## Installed Artifacts

- `governance/agenthub-closed-loop-recovery-policy.md`
- `schemas/spawned_worker_dispatch.schema.json`
- `schemas/closed_loop_autonomy.schema.json`
- `validators/closed_loop_recovery_validator.rb`
- `evals/closed-loop-recovery/fixtures.json`
- `prompts/closed-loop/agenthub_closed_loop_worker_dispatch.txt`
- `prompts/closed-loop/agenthub_architect_recovery_contract.txt`

## Codex CLI Classification

Verified by safe local `codex --help` and subcommand help:

- `codex exec`: `IMPLEMENT_NOW` for bounded non-interactive workers with
  receipt schema.
- `--model`, `--profile`, `--sandbox`, `--ask-for-approval`, `--config`,
  `--strict-config`, `--json`, `--output-last-message`: `IMPLEMENT_NOW` when
  wrapped by AgentHub receipts.
- `codex mcp` and `codex mcp-server`: `USE_IN_POLICY_ONLY` unless a real MCP
  tool/list/execution receipt exists.
- `codex doctor`, `codex features`, `codex debug models`: `USE_IN_POLICY_ONLY`
  diagnostics, not Done proof.
- `codex plugin`: `USE_IN_POLICY_ONLY`; plugin enablement still requires
  supply-chain intake.
- `codex apply`, `codex resume`, `codex fork`: `USE_IN_POLICY_ONLY`; not
  closure proof.
- `--remote` and `--remote-auth-token-env`: `EXPERIMENTAL_DEFER` for this
  control-spine recovery.
- dangerous bypass flags: `FORBIDDEN`.

Slash/TUI commands remain interactive diagnostics, not durable backend proof.

## Priority Register

P0:
- fake PASS / fake Done;
- T0 direct mutation;
- requested/actual model mismatch;
- same-gate retry loops;
- user-action leakage;
- secret/raw link exposure;
- forbidden runtime mutation;
- artifact lifecycle drift;
- duplicate RUN/worker/PR loops.

P1:
- spawned dispatch schema;
- closed-loop autonomy schema;
- actual model proof gate;
- lifecycle/PR queue/task readback gate;
- prompt quality and red-team controls;
- approval/sandbox policy.

P2:
- model cost routing;
- subagent token budgets;
- Codex CLI diagnostic automation;
- context pack compression.

## Red-Team Results

PASS by `closed_loop_recovery_validator.rb` fixtures:

- wrong-task and stale-source prevention through lifecycle gate;
- role drift through T0 boundary gate;
- evidence fraud through model/MCP/product proof gates;
- scope creep through forbidden-surface gate;
- user-action leak gate;
- token/retry-loop gate;
- PR-tail gate;
- secret/raw-link gate;
- replay/artifact lifecycle gate;
- model-route hallucination gate;
- spawned-worker conflict gate;
- Hiddify domain contamination gate;
- dangerous CLI bypass gate.

## Safety

- No product/runtime mutation.
- No Docker, DB, proxy, firewall, DNS, SSL, service restart, secret read, or
  environment dump.
- No Hiddify live repair was performed; Hiddify remains a child-task evidence
  surface requiring scoped live authority for runtime/browser closure.
