---
artifact_id: P0-codex-spark-real-execution-proof-receipt-20260529
artifact_type: operational-receipt
owner_role: Verifier / Registrar
source_task: AH-601
run_id: RUN-P0-CODEX-SPARK-REAL-WORKER-PROOF-20260529
created_at: 2026-05-29
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# P0 Codex Spark Real Execution Proof Receipt

receipt_id: P0-codex-spark-real-execution-proof-receipt-20260529

task_id: AH-601

run_id: RUN-P0-CODEX-SPARK-REAL-WORKER-PROOF-20260529

## Result

final_state: DONE_WITH_EVIDENCE

done_allowed: true

closed_blocker: CODEX_SPARK_EXECUTION_NOT_PROVEN

residual_non_blocking_limit: CODEX_SPARK_COST_TELEMETRY_UNAVAILABLE

## Proof Worker

| Field | Value |
|---|---|
| worker_id | `W-codex-spark-real-execution-proof-03` |
| requested_model | `gpt-5.3-codex-spark` |
| actual_model_source | `codex exec -m gpt-5.3-codex-spark` inside AgentHub command worker |
| fallback_used | `false` |
| task_class | `code_config_yaml_proof` |
| proof artifact | `@agenthub-runs/p0-codex-spark-real-worker-proof-20260529/spark-real-execution-proof.md` |
| proof artifact sha256 | `585329a55461ae72817410ddb9a48c1ebba1c0cf4aba3d06ffcefa9edf5cba63` |
| AgentHub ledger sha256 | `181f82fa72cbde1b46e5d8456550ec9ed0e80aa120b75e62f4c8caa88156e570` |

## Gates

| Gate | Result |
|---|---|
| AgentHub MCP create | PASS |
| AgentHub MCP dispatch | PASS |
| AgentHub MCP execute | PASS |
| AgentHub MCP merge | PASS |
| Spark model invocation receipt | PASS |
| Usage object present in event stream | PASS |
| GPT-5.5 code/config proof avoided | PASS |
| fallback avoided | PASS |
| path_safety_gate | PASS |
| secret_redaction_gate | PASS |
| no_forbidden_zone_touched | PASS |
| client_project_write | false |

## Notes

Two earlier command attempts failed before model invocation because approval
flags were not accepted by the installed Codex CLI argument parser. They are
recorded as correctable command-shape failures and are not counted as model
fallbacks.

The successful attempt produced a model invocation stream and worker final
evidence for the requested Spark model. No secret values, environment dumps,
raw credentials, or service/runtime logs are stored in this receipt.
