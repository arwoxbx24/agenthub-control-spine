---
artifact_id: P0-codex-spark-mandatory-execution-factcheck-20260529
artifact_type: audit-report
owner_role: Verifier / Registrar
source_task: AH-601
run_id: RUN-P0-CODEX-SPARK-MANDATORY-GUARDRAIL-AUDIT-20260529
created_at: 2026-05-29
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# P0 Codex Spark Mandatory Execution Factcheck

## Scope

This is a read-only/control-spine audit of the Codex Spark mandatory execution
guardrail. It checks what is installed, what is duplicated, and what is still
not proven.

No production service, Docker, DB, proxy, firewall, secret, or product runtime
state was changed by this audit.

## Source Tasks And PRs Read Back

| Surface | Evidence | Verdict |
|---|---|---|
| AH-597 | Codex development model route task is Done. It records Spark-first route install for explicit development/code/config/YAML/shell requests and fallback to Codex. | Installed as route/policy, not execution proof. |
| AH-590 | Self-healing/model-router governance task is Done. It records model route controls and Done gates. | Installed as governance/control-spine controls. |
| PR #82 | Merged Codex model routing and surface-bound controls. | Installed. |
| PR #84 | Merged fallback-evidence gate tightening. | Installed. |
| Runtime contract | TeamLead remains `gpt-5.5`; helper allowlist includes `gpt-5.3-codex-spark`. | Registered helper route, not execution proof. |

## Installed Controls

| Control | Evidence | Result |
|---|---|---|
| T0 no-code policy | T0 direct-action validators and fixtures reject direct authorship. | Installed. |
| Codex-capable model route policy | Model routing policies and validators require Codex-capable models for code/config classes. | Installed. |
| Spark-first requested development route | Runtime routing config and selector references resolve explicit Codex Spark development requests to Spark with Codex fallback. | Installed. |
| Fallback evidence gate | PR #84 requires same-RUN primary-unavailable evidence for non-primary fallback. | Installed. |
| Negative tests for T0 and fallback | Targeted validators pass for existing fixture suites. | Installed. |

## Not Proven Or Missing

| Requirement | Finding | Typed status |
|---|---|---|
| Actual Spark execution for a code/config task | No runtime receipt or usage telemetry proving `gpt-5.3-codex-spark` executed was found in this audit. | CODEX_SPARK_EXECUTION_NOT_PROVEN |
| Usage delta/telemetry | No evidence source proving Spark usage decreased after a code/config task was found. | CODEX_SPARK_USAGE_PROOF_UNAVAILABLE |
| Mandatory 2026-05-29 report/receipt before this audit | No pre-existing `P0-codex-spark-mandatory-execution-*20260529` report/receipt was found. | CONTROL_SPINE_REPORT_REQUIRED, now remediated by this audit package |
| Exact `BLOCKED_WRONG_MODEL_FOR_CODE` string | Existing validators block wrong model under older names such as Codex-route-required/non-Codex model denial. The exact requested blocker string was not found. | BLOCKER_NAME_DRIFT |
| Exact `CODEX_ROUTE_GATE_BEFORE_MODEL_INVOCATION` string | Existing controls identify route/model evidence gaps, but this exact requested blocker string was not found. | BLOCKER_NAME_DRIFT |
| One harmless positive Spark execution | Not run by this audit. Running it requires a real Codex Spark worker invocation route and telemetry/receipt. | CODEX_SPARK_EXECUTION_NOT_PROVEN |

## Duplicate Check

No duplicate 2026-05-29 mandatory execution audit package existed before this
audit. Older artifacts exist and remain valid for policy/governance:

- PR #82: model-router and surface-bound controls.
- PR #84: fallback evidence gate.
- AH-597: runtime route install/readback.
- AH-590: broader self-healing/model-routing controls.

This audit does not duplicate those artifacts. It records the missing runtime
execution proof layer requested by the owner.

## Truth Verdict

Not DONE_WITH_EVIDENCE for the mandatory execution guardrail contract.

Current final blocker:

`CODEX_SPARK_EXECUTION_NOT_PROVEN`

Secondary blocker:

`CODEX_SPARK_USAGE_PROOF_UNAVAILABLE`

The installed controls are real policy/runtime-route controls, but actual Spark
execution and usage telemetry are still not proven by the available evidence.
