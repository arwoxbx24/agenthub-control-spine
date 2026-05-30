---
artifact_id: P0-codex-spark-json-usage-execution-audit-20260529
artifact_type: audit
owner_role: T1 Architect / Verifier
source_task: AH-601
run_id: agenthub-emergency-worker-route-unblock-codex-spark-json-20260529-0819
created_at: 2026-05-29
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# P0 Codex Spark JSON Usage Execution Audit

## Result

Codex Spark route closure now has a stronger local execution receipt than the
previous command-request proof:

- AgentHub MCP run:
  `agenthub-emergency-worker-route-unblock-codex-spark-json-20260529-0819`
- worker: `W-codex-spark-json-event-proof-01`
- requested model: `gpt-5.3-codex-spark`
- proof source: `codex_cli_json_usage_receipt`
- Codex JSON usage: input tokens `27158`, output tokens `823`
- proof artifact hash:
  `e397568b10627f09cc6cd9cc08bce42df832d588084f2538bb6318ec92ee4165`
- event receipt hash:
  `aeb18747b7a092eb1b5902e846e95bfefd1eafafd29061b9ff23db094f54ac52`

## Factcheck Boundary

Rejected proof remains rejected:

- command request without JSON usage;
- worker self-report only;
- policy-only or validator-only evidence;
- merged PR only;
- sandbox-only evidence without a Codex invocation receipt.

Accepted proof now includes Codex CLI JSON event usage for an explicit
`gpt-5.3-codex-spark` invocation, provided fallback was not used and non-zero
usage tokens exist.

If the owner-visible platform usage meter still shows no Spark usage after this
run, record the residual as platform usage-meter drift, not as a missing local
Codex invocation.

