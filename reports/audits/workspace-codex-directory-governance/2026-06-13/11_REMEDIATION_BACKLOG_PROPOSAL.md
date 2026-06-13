---
artifact_id: workspace-codex-directory-governance-remediation-backlog-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# Remediation Backlog Proposal

No implementation performed in this audit.

## Priority 1

1. Directory governance policy: classify allowed write locations and forbidden final-artifact locations.
2. Write-location guard: block final reports/receipts outside registered surfaces.
3. Done-gate dry-run + explain-gate endpoint: return required parser markers/fields before status mutation.
4. No-blind-retry hook: after first gate fail, force exact-error source lookup.

## Priority 2

5. Run-output lifecycle ledger: owner task, RUN_ID, worker, lifecycle, TTL/quarantine decision.
6. Evidence ledger: claim-to-proof mapping for final reports.
7. Browser-first testing contract for user-facing services.
8. Prompt/report lifecycle hardlock: reports/receipts/prompts default_load=false unless active policy/schema/context.

## Priority 3

9. Workspace owner labeling for unknown directories.
10. Quarantine plan for temp/orphan candidates after owner review.
11. Git branch receipt normalizer to prevent local/GitHub branch drift.

## Suggested YouTrack Structure

Parent: Workspace/Codex Directory Governance Repair.
Children: write guard, done dry-run, explain endpoint, run lifecycle ledger, evidence ledger, browser-first testing, prompt lifecycle, quarantine plan.
