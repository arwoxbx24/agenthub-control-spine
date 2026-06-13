---
artifact_id: workspace-codex-directory-governance-next-prompt-reqs-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# Next Implementation Prompt Requirements

Do not generate full implementation prompt unless owner asks after audit.

## Required Controls

- directory governance policy;
- write-location guard;
- temp-folder blocker;
- Done-gate dry-run;
- explain-gate endpoint;
- evidence ledger;
- browser-first testing contract;
- no-blind-retry hook;
- run-output lifecycle ledger;
- prompt/report lifecycle hardlock;
- task-service canonical marker writer.

## Required Execution Boundaries

- Use existing audit branch findings as source packet.
- Create new implementation task/RUN or linked child from AH-786.
- No cleanup/delete until classification and owner review.
- No Docker/proxy/DB/firewall/runtime service mutation unless exact scoped authority.
- No client-facing delivery claims.

## Required Acceptance

- Fixtures proving wrong write paths blocked.
- Fixtures proving Done explain/dry-run returns parser markers.
- Fixtures proving routine blockers become PackFix.
- Fixtures proving reports/prompts cannot become active instruction by default.
- Register updates and receipt readback.
