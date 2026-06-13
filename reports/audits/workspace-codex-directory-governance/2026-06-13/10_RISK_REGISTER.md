---
artifact_id: workspace-codex-directory-governance-risk-register-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# Risk Register

| Risk | Severity | Occurrence | Detection | Owner | Blast radius | Mitigation proposal | Evidence |
|---|---:|---:|---:|---|---|---|---|
| Final artifacts written to random runtime/project folders | 8 | 7 | 4 | Registrar | repo + task closure | write-location guard | bounded listings |
| Secret-risk folders exposed by broad audit | 9 | 4 | 5 | Security | credentials/client data | redacted inventory only | no content read |
| Fake Done by semantic evidence | 9 | 6 | 4 | Task service | YouTrack trust | parser-first Done dry-run | AH-785 lesson |
| Blind retry loop after gate fail | 8 | 7 | 5 | Runtime | token/time/task churn | no-blind-retry hook | repeated run names |
| Runtime run-output growth | 7 | 8 | 5 | AgentHub runtime | storage/confusion | run lifecycle ledger | run listing |
| Prompt/report replay as active policy | 8 | 5 | 5 | Registrar | wrong instructions | lifecycle hardlock | register model |
| Browser proof missing for UI claims | 8 | 5 | 5 | QA | false delivery | evidence hierarchy | testing model |
| GitHub/local branch drift | 7 | 5 | 4 | Git registrar | lost/unreviewed changes | single branch receipt | revision guard/gateway |
| Owner-chat routine blockers | 7 | 6 | 5 | Agent cycle | user interruption | PackFix loop | observed task flow |
| Unknown project ownership | 6 | 7 | 6 | Workspace registrar | cleanup risk | owner labels | inventory table |

## Highest Priority

Install write-location guard, Done dry-run/explain endpoint, and run-output lifecycle ledger before cleanup.
