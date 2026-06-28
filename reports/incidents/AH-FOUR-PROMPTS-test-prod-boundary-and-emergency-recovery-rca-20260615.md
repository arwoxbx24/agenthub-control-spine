---
artifact_id: AH-FOUR-PROMPTS-test-prod-boundary-and-emergency-recovery-rca-20260615
artifact_type: incident-analysis
owner_role: T1 Architect / Verifier
source_task: RUN-20260615-FOUR-PROMPTS-SYSTEM-ARCH
run_id: RUN-20260615-FOUR-PROMPTS-SYSTEM-ARCH
created_at: 2026-06-15
lifecycle_status: analysis_complete
default_load: false
safe_to_replay: false
---

# Test/Prod Boundary and Emergency Recovery RCA

## Timeline

1. A test-scoped workflow was treated as safe without machine-readable
   environment proof.
2. Product repository branch/workflow semantics were allowed to imply target
   environment.
3. Owner distress was handled as chat pressure instead of a P0 incident signal.
4. Closure language appeared before route, validation, PR/task, and recovery
   evidence were complete.

The timeline is intentionally redacted and neutral. It does not preserve abusive
phrasing or raw transcript fragments.

## What Happened

The system allowed ambiguity between test and production lanes, then mixed
ordinary feature/test work with incident recovery. It also lacked one terminal
gate that tied owner distress, environment proof, workflow impact, rollback, and
Done evidence into one deterministic state machine.

## Why It Was Unsafe

- Test scope could route through product `main`/`master`.
- Workflow name could be mistaken for workflow impact proof.
- Owner incident signal could produce apology/stop loops instead of safe
  recovery.
- Rollback could be discussed before last-known-good and reversibility proof.
- PR or workflow status could be mistaken for user outcome or Done.

## Failed Gates

- `ENVIRONMENT_CLASSIFICATION_MISSING`
- `TEST_ONLY_PROOF_MISSING`
- `MASTER_EQUALS_PROD_RISK_NOT_BLOCKED`
- `WORKFLOW_IMPACT_AUDIT_MISSING`
- `OWNER_DISTRESS_SIGNAL_NOT_ROUTED_TO_INCIDENT`
- `SAFE_ROLLBACK_LANE_MISSING`
- `CHAT_PARALYSIS_AFTER_SITE_BROKEN`
- `REMOTE_FETCH_ASSUMPTION_UNPROVEN`
- `TEST_SERVER_ROUTE_UNVERIFIED`

## 5 Whys

1. Why could test work threaten production? Environment proof was not mandatory.
2. Why was proof missing? Branch/workflow names were treated as enough context.
3. Why did incident recovery stall? Owner distress was not a typed incident
   trigger.
4. Why could closure be weak? Done evidence was split across PR, task, register,
   validation, and receipt gates.
5. Why did the failure repeat? The four prompt requirements were not installed
   as one deterministic validator-backed state machine.

## Fishbone

| Category | Cause | Control |
|---|---|---|
| Process | Test and production lanes mixed | Test-only proof gate |
| Tooling | Workflow impact hidden | Workflow impact audit |
| Repo/workflow | `main`/`master` implied deploy risk | Environment classifier |
| Role boundary | T0 could drift into action | Task/RUN/worker binding |
| Validation | PR/workflow success treated as Done | Done evidence gate |
| Communication | Owner distress treated as chat | Incident trigger gate |

## FMEA

| Failure mode | Severity | Occurrence | Detection | Required control |
|---|---:|---:|---:|---|
| Accidental production deploy | 10 | 6 | 4 | Test-only proof + prod phrase |
| Wrong remote workaround | 8 | 5 | 5 | Archived/read-only remote PackFix |
| Workflow side effect | 9 | 6 | 4 | Workflow impact audit |
| Branch/master confusion | 9 | 7 | 5 | Product `main`/`master` prod-risk gate |
| Owner signal ignored | 9 | 5 | 5 | Owner distress incident gate |
| Blind rollback | 10 | 4 | 4 | Safe rollback lane |
| Fake Done | 8 | 6 | 6 | Done evidence tuple |

## Premortem

The recurrence path is predictable: an agent sees "test", trusts a branch or
workflow name, runs or merges without impact audit, then reacts to owner panic
with chat instead of read-only triage. The prevention path is to block all
unknown test/prod boundaries until proof exists and to treat owner distress as a
state-machine event.

## Minimal Safe Correction

Install one policy, seven schemas, one validator, fixtures, a runbook, a worker
template, register coverage, validation report, receipt, and truth ledger. Do
not mutate product/runtime surfaces while installing this governance package.

