---
artifact_id: P0-codex-spark-route-true-execution-audit-20260528
artifact_type: audit-report
owner_role: T1 Architect / Verifier
source_task: AH-590
run_id: RUN-P0-CODEX-SPARK-TRUE-EXECUTION-20260528
created_at: 2026-05-28
lifecycle_status: audit_only
safe_to_replay: false
---

# P0 Codex Spark Route True Execution Audit

## Scope

Owner reported that Codex Spark policy exists but real usage remains unproven, and AgentHub rejects a missing-access blocker that does not name the missing access surface.

This audit is repository/control-spine scope only. It does not touch runtime services, Docker, proxy, database, secrets, or domains.

## Findings

- H1 confirmed: policy and PR evidence alone do not prove Spark execution.
- H2 confirmed for the active runtime route: command/live worker dispatch can be blocked before model selection.
- H3 confirmed by owner-provided failure: missing-access blocker must state the exact missing access.
- H4 confirmed as a governance risk: fallback must be same-RUN and must prove Spark unavailable.
- H5 confirmed as a closure risk: Done must require runtime model execution proof or exact typed blocker.

## Installed Control-Spine Repair

Added:

- `schemas/agenthub_missing_access_blocker.schema.json`
- `validators/agenthub_missing_access_and_spark_proof_validator.rb`
- `evals/agenthub-missing-access-spark-proof/fixtures.json`

The validator rejects generic missing-access blockers and rejects Spark policy claims without runtime receipt, telemetry, or usage proof.

## Runtime Proof Status

Codex Spark execution is not proven in this run. The AgentHub sandbox route produced only sandbox-worker evidence, not a Spark model execution receipt.

Required unresolved proof:

- AgentHub model execution receipt with Spark model id; or
- provider/adapter telemetry confirming Spark worker start and completion; or
- authorized usage delta evidence.

## Typed Blocker

`CODEX_SPARK_USAGE_PROOF_UNAVAILABLE`

Reason: control-spine gates can now reject fake proof, but this run does not have real Spark execution telemetry or usage delta evidence.
