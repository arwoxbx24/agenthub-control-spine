---
artifact_id: P0-codex-spark-usage-metric-contradiction-receipt-20260529
artifact_type: operational-receipt
owner_role: Truth Redteam / Registrar
source_task: AH-601
run_id: RUN-P0-CODEX-SPARK-USAGE-METRIC-CONTRADICTION-20260529
created_at: 2026-05-29
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# P0 Codex Spark Usage Metric Contradiction Receipt

receipt_id: P0-codex-spark-usage-metric-contradiction-receipt-20260529

task_id: AH-601

run_id: RUN-P0-CODEX-SPARK-USAGE-METRIC-CONTRADICTION-20260529

## Correction

prior_receipt: P0-codex-spark-real-execution-proof-receipt-20260529

prior_pr: #98

prior_merge_commit: d29d5fedfd7585dde0f2d9d13654c75eb8b37309

correction_reason: owner-visible GPT-5.3-Codex-Spark usage metric remains 100%
available and shows no usage data after the alleged proof.

## Normalized Result

final_state: BLOCKED

done_allowed: false

primary_blocker: CODEX_SPARK_USAGE_TELEMETRY_UNAVAILABLE

secondary_blocker: CODEX_SPARK_EXECUTION_NOT_PROVEN_BY_PLATFORM_METRIC

## Evidence Boundary

| Evidence | Status |
|---|---|
| AgentHub MCP lifecycle for PR #98 proof run | Valid lifecycle evidence |
| Command requested with `-m gpt-5.3-codex-spark` | Valid request evidence |
| Worker output says `actual_model=gpt-5.3-codex-spark` | Self-report only |
| Owner-visible Spark usage meter | Contradicts usage claim |
| Independent platform resolved-model receipt | Missing |

## Done Gate

AH-601 is not Done.

The next closure attempt must attach independent platform/model proof or keep
the blocker active. A sandbox artifact, command argument, or worker self-report
must not be accepted as real Spark usage proof when the usage meter contradicts
it.
