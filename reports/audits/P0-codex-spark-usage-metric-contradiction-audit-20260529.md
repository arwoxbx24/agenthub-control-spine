---
artifact_id: P0-codex-spark-usage-metric-contradiction-audit-20260529
artifact_type: audit-report
owner_role: Truth Redteam / Registrar
source_task: AH-601
run_id: RUN-P0-CODEX-SPARK-USAGE-METRIC-CONTRADICTION-20260529
created_at: 2026-05-29
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# P0 Codex Spark Usage Metric Contradiction Audit

## Scope

This audit corrects the prior closure claim for AH-601 after owner-visible
usage telemetry contradicted the local proof package.

The owner reported that the GPT-5.3-Codex-Spark limit surface still shows 100%
remaining for the 5-hour window and no usage data. That external readback
contradicts the claim that the prior proof consumed or executed Spark in a way
accepted by the platform usage meter.

No production service, Docker, DB, proxy, firewall, secret, or product runtime
state was changed by this correction.

## Claim Ledger

| Claim | Prior source | Required evidence | Current evidence | Verdict |
|---|---|---|---|---|
| PR #98 proves actual Spark usage. | `P0-codex-spark-real-execution-proof-*` package. | Owner-visible usage metric decrease or platform/model invocation receipt independent of worker text. | Owner reports Spark metric remains 100% and no usage data. | CONTRADICTED |
| `codex exec -m gpt-5.3-codex-spark` proves actual model execution. | AgentHub command worker artifact. | Invocation receipt that names the resolved model from the platform, or matching usage telemetry. | Command argument and worker self-report only; no independent resolved-model field was captured. | PARTIAL |
| AgentHub MCP merge `done_allowed=true` proves model usage. | AgentHub v2 merge receipt. | Merge receipt plus independent model/usage proof. | Merge proves worker artifact lifecycle, not platform model consumption. | INSUFFICIENT |
| AH-601 can stay Done. | YouTrack closure after PR #98. | All acceptance gates closed without contradictions. | Usage metric contradiction is active. | FALSE_DONE |

## Normalized Status

Wrapper and ledger success are downgraded by the stronger residual evidence.

Normalized final state:

`BLOCKED`

Primary blocker:

`CODEX_SPARK_USAGE_TELEMETRY_UNAVAILABLE`

Secondary blocker:

`CODEX_SPARK_EXECUTION_NOT_PROVEN_BY_PLATFORM_METRIC`

## Required Proof For Future Closure

AH-601 must not return to Done until one of these exists:

1. owner-visible Spark usage metric changes from the proof run; or
2. a platform/model invocation receipt names `gpt-5.3-codex-spark` as the
   resolved model independently from the worker prompt/output; or
3. an owner-only/platform blocker proves the account/plan/telemetry surface
   cannot expose Spark usage for this environment.

Command-line request text, model self-report, sandbox success, and AgentHub
merge success are not enough by themselves.
