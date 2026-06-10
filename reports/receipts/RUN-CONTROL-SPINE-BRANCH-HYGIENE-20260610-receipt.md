---
artifact_id: run-control-spine-branch-hygiene-20260610-receipt
artifact_type: operational_receipt
owner_role: T0 Registrar / Verifier
source_task: AH-731 / AH-733 / AH-738
run_id: RUN-CONTROL-SPINE-BRANCH-HYGIENE-20260610
created_at: 2026-06-10
updated_at: 2026-06-10
lifecycle_status: operational_receipt
default_load: false
safe_to_replay: false
---

# Control-Spine Branch Hygiene Receipt

## Single Active Cleanup Contour

Repository: `arwoxbx24/agenthub-control-spine`.

Only active cleanup contour:

- PR: `#149`
- branch: `agenthub/control-spine-branch-hygiene-20260610`
- task: `AH-731`
- repair task: `AH-738`
- run: `RUN-CONTROL-SPINE-BRANCH-HYGIENE-20260610`

## PR Sprawl Collapse

| PR | Branch | Decision | Preservation |
|---|---|---|---|
| `#149` | `agenthub/control-spine-branch-hygiene-20260610` | `ACTIVE_CLEANUP_CONTOUR` | execution remains here only |
| `#150` | `agenthub/deep-blocker-audit-20260610` | `STALE_CLOSE_PRESERVE_AUDIT_ONLY` | closed; useful audit content preserved in PR history |
| `#151` | `agenthub/self-healing-blocker-removal-20260610` | `STALE_CLOSE_PRESERVE_AUDIT_ONLY` | closed; useful route evidence preserved in PR history |

No branch content from #150/#151 was deleted in this run.

## Delete Route Result

The previous `BRANCH_DELETE_EXECUTOR_BLOCKED` state is resolved for the approved 10-branch set. Each branch passed `github_delete_branch_ref` dry-run first, then was deleted with SHA pinning, protected-branch protection, open-PR branch check, YouTrack readback flag, `task_id=AH-731`, and `run_id=RUN-CONTROL-SPINE-BRANCH-HYGIENE-20260610`.

Remote branch deletions performed: `10`.

| Branch | Deleted SHA | Receipt |
|---|---:|---|
| `agenthub/AH-501-secret-exclusion-receipt-20260522` | `f46275fc1b22201c8b48af196e92bf918321cfd0` | `DELETE_REF_CONFIRMED` |
| `agenthub/RUN-AGENTHUB-CONTOUR-TASK-GRAPH-20260601` | `164e7243e237db68489fd34b53672b8879f5cd0d` | `DELETE_REF_CONFIRMED` |
| `agenthub/RUN-AGENTHUB-CONTOUR-TASK-GRAPH-20260601-readback` | `9220face4621ec2aa5b0d2c9d416481a2bba5f2f` | `DELETE_REF_CONFIRMED` |
| `agenthub/RUN-P0-FINAL-CONTOUR-RUNTIME-ENFORCEMENT-20260601` | `1404d9e4fb6c6f7f0712c695b064a91fac6084f8` | `DELETE_REF_CONFIRMED` |
| `agenthub/RUN-P0-FINAL-CONTOUR-RUNTIME-ENFORCEMENT-20260601-merge-readback` | `6c653f89b95eaea23bd5c512e5ad98f4fbf3f763` | `DELETE_REF_CONFIRMED` |
| `agenthub/RUN-P0-IMPLEMENT-SPARK-ROUTE-RESTORE-20260529` | `68593953dfd3414b8c066bed250a8f7ad098cfcb` | `DELETE_REF_CONFIRMED` |
| `agenthub/RUN-P0-METHODOLOGY-ENFORCEMENT-CERTIFICATION-20260528` | `52ec1e49ee5abbf80c8a8331a18ed66498cbc666` | `DELETE_REF_CONFIRMED` |
| `agenthub/RUN-P0-METHODOLOGY-ENFORCEMENT-CERTIFICATION-20260528-readback` | `9da783161670b0dec849164f4ecaaed5198404db` | `DELETE_REF_CONFIRMED` |
| `agenthub/RUN-P0-PR82-FALLBACK-GATE-20260528` | `724a636e5b13d27cd33b8058b0d7099b13ec1a1e` | `DELETE_REF_CONFIRMED` |
| `agenthub/RUN-P0-PR82-FALLBACK-GATE-20260528-readback` | `ff14e23cfa6f87c3ebb649b5296c01de6d7360b6` | `DELETE_REF_CONFIRMED` |

## PR Branch Noise Cleanup

PR #149 was reduced to this receipt plus the `gitleaks` status-route workflow repair. The following PR-local noise artifacts were removed from the branch before merge:

- `prompts/architecture/AGENTHUB-CHATGPT-WEB-DATA-INTAKE-CLOSURE-ARCHITECTURE-20260610.txt`
- `prompts/architecture/AGENTHUB-CHATGPT-WEB-NO-MCP-WORDING-20260610.txt`
- `prompts/architecture/AGENTHUB-PR149-NO-BLOCKER-REPEAT-ACTION-ONLY-20260610.txt`
- `prompts/architecture/AGENTHUB-PR149-NO-MIRROR-NO-STATUS-LOOP-20260610.txt`
- `prompts/architecture/AGENTHUB-PR149-PLAIN-LANGUAGE-AGENT-UNBLOCK-20260610.txt`
- `prompts/architecture/AGENTHUB-PR149-SINGLE-BRANCH-PR-QUEUE-RESCUE-20260610.txt`
- `prompts/architecture/AGENTHUB-PR149-TASK-GATE-SANDBOX-SUCCESS-TRUTH-20260610.txt`
- `prompts/architecture/AGENTHUB-PR149-ULTRA-SIMPLE-AGENT-INSTRUCTION-20260610.txt`
- `prompts/incident/AGENTHUB-BRANCH-HYGIENE-DELETE-REF-ROUTE-UNBLOCK-20260610.txt`
- `reports/audits/AGENTHUB-BRANCH-HYGIENE-BLOCKER-REPORT-20260610.md`

## Merge Gate Repair

- Failing gate: GitHub branch protection required legacy status context `gitleaks` while the workflow only emitted an Actions check-run.
- Repair action: `.github/workflows/secret-scan.yml` now grants `statuses: write` and publishes legacy commit status `gitleaks` after successful redacted scan.
- Head-only status was insufficient because GitHub evaluated a synthetic PR merge SHA; the workflow now publishes status on both PR head SHA and `github.sha`.
- PR branch was rebuilt from current `main` to remove `behind_by=1` and stop synthetic merge-SHA churn.

## Safety

- Repository deletion: no.
- Protected branch deletion: no.
- Open PR head branch deletion: no.
- Fresh branch broad cleanup: no.
- Branch protection change: no.
- Runtime/Docker/DB/proxy/firewall/DNS/SSL/ports/secrets/product mutation: no.
- Raw token/secret output: no.

## Current State

`BRANCH_HYGIENE_AND_GITLEAKS_STATUS_ROUTE_REPAIRED`

## Final Owner Output

Fact: PR #149 branch hygiene done; 10 stale branches deleted; `gitleaks` required-status route repaired.
Action: merge PR #149 after final `gitleaks` readback on rebased head.
Left: none
