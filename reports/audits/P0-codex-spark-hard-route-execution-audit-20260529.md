---
artifact_id: P0-codex-spark-hard-route-execution-audit-20260529
artifact_type: audit-report
owner_role: T1 Architect / Truth Redteam / Registrar
source_task: AH-601
run_id: RUN-P0-CODEX-SPARK-USAGE-METRIC-CONTRADICTION-20260529
created_at: 2026-05-29
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# P0 Codex Spark Hard Route Execution Audit

## Scope

This audit is the hard-route closure pass for the Codex Spark execution error
cycle. It uses the latest owner readback as source of truth: the
GPT-5.3-Codex-Spark usage meter still shows 100% available and no usage data
after the previous claimed proof.

No production service, Docker, NPM, DB, proxy, firewall, secret, or product
runtime state was changed. No new `codex exec -m gpt-5.3-codex-spark` proof was
run, because the last command-request proof did not move the Spark usage meter
and may have consumed the primary agent limit instead.

## Intake Freeze

Latest owner intent:

Force real Codex Spark execution for code/config work, stop primary model code
authorship, close the fake Done loop, and install or record self-healing route
controls without another prompt-only or PR-only closure.

## Fact Binding

| Surface | Finding | Verdict |
|---|---|---|
| PR #97 | Correctly found that policy/validator install was not execution proof. | Valid historical audit. |
| PR #98 | Proved AgentHub lifecycle and command request with `-m gpt-5.3-codex-spark`, but not independent platform usage. | Partial evidence only. |
| PR #99 | Correctly downgraded PR #98 after owner-visible usage metric contradiction. | Current source of truth. |
| AH-601 | Stage is Review; active blocker is `CODEX_SPARK_USAGE_TELEMETRY_UNAVAILABLE`. | Correct state. |
| Owner usage readback | Spark limit remains 100% with no usage data. | Contradicts `DONE_WITH_EVIDENCE`. |

## Hard Route Findings

| Required control | Current status |
|---|---|
| Code/config/YAML/shell routes to Codex-capable worker | Installed by existing model-router/action-policy controls. |
| Spark-first route exists | Installed as requested route/policy. |
| GPT-5.5/T0 direct code authorship blocked | Installed in existing T0/action-policy controls. |
| Fallback requires same-RUN primary-unavailable evidence | Installed by prior fallback gate. |
| Policy-only/validator-only proof rejected | Installed by PR #97/#99 correction path. |
| Command-request/self-report proof rejected when usage metric contradicts it | Installed by PR #99 and this audit package. |
| Independent platform resolved-model or usage proof captured | Missing. |

## Proof Worker Decision

The required proof worker was not rerun in this pass.

Reason: the previous attempt used an AgentHub command worker and a Codex CLI
model request, but the owner-visible usage meter did not record Spark usage.
Repeating the same mechanism would likely produce another command-request
artifact without independent model evidence and would risk burning the primary
agent limit again.

## Normalized Final State

`BLOCKED_WITH_PROOF`

Terminal blocker:

`CODEX_SPARK_USAGE_TELEMETRY_UNAVAILABLE`

Secondary evidence note:

`CODEX_SPARK_EXECUTION_NOT_PROVEN_BY_PLATFORM_METRIC`

This is not a generic blocked state. It is the exact blocker selected because
the system lacks an independent platform/model receipt or owner-visible usage
delta for `gpt-5.3-codex-spark`.

## Required Evidence For Future Done

AH-601 can move to Done only when one of these exists:

1. owner-visible Spark usage decreases after a proof worker run; or
2. a platform/model invocation receipt names `gpt-5.3-codex-spark` as the
   resolved model independently from command arguments and worker text; or
3. the platform/account proves Spark usage telemetry is unavailable, in which
   case the terminal state remains an owner/platform blocker, not Done.

Rejected proof classes:

- merged PR;
- installed policy;
- installed validator;
- audit or receipt alone;
- sandbox result without independent model identity;
- `codex exec -m` command line by itself;
- worker self-report of `actual_model`;
- GPT-5.5/main model output;
- task Done without model/usage evidence.

## Downstream Hot Lane

Downstream tasks such as AH-569 or AH-600 were not touched. The Spark route
proof remains blocked, so downstream route blockers must remain task-specific
and must not be cleared from PR-only or command-request evidence.
