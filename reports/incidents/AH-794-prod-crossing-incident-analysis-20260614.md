---
artifact_id: AH-794-prod-crossing-incident-analysis-20260614
artifact_type: incident-analysis
source_task: AH-794
run_id: AH-PROD-LOCK-TEST-FIRST-GOVERNANCE-20260614
status: evidence_report
safe_to_replay: false
---

# AH-794 Production Crossing Incident Analysis

## Evidence Packet

- YouTrack AH-793 readback: test-only banner validation task, explicit production prohibition, later incident/rollback comment.
- YouTrack AH-520 readback: parent banner upload task, test-first production rollout requirement.
- GitHub PR #154 in `arwoxbx24/stroyremont`: title `AH-793 banner upload validation messages`, base `master`, head `agenthub/AH-793-banner-errors-test`, merged at `2026-06-14T18:00:38Z`, merge commit `c57dd0f1e6c0d2225e8ebef1e0df0d174f23696b`.
- GitHub PR #155 in `arwoxbx24/stroyremont`: rollback PR, base `master`, merged at `2026-06-14T18:05:21Z`, merge commit `ac988229aaf4cebc335e9b34d42eb4dc6c63eaae`.
- Repository fact: `arwoxbx24/stroyremont` default branch is `master`.
- Official GitHub facts: branch filters must be read from workflow syntax; environments can require approvals, branch restrictions, protection rules, and secret gating; protected branches can require reviews/status checks before merge.

## Timeline

1. AH-793 was created as a test-only task for clearer banner upload errors.
2. Implementation evidence existed locally/static, but browser/test deployment proof was missing or blocked.
3. PR #154 was opened with a test-only description but targeted `master`.
4. PR #154 was merged into `master` at `2026-06-14T18:00:38Z`.
5. This crossed the test-only route into production risk because `master` is the product repository default branch and can trigger production workflows.
6. PR #155 rollback was created and merged at `2026-06-14T18:05:21Z`.
7. AH-793 remained not Done pending valid test-only route and browser/user outcome proof.

## Exact Failed Route

`test-only task -> PR to master -> merge to master -> production-risk workflow/deploy route -> rollback`

The crossing point was PR #154 targeting and merging into `master` before a test-only route proof and workflow impact audit proved no production effect.

## Failed Gates

- Test-only route proof gate: missing before merge.
- Workflow impact audit gate: missing before PR/merge.
- Environment classifier gate: `master` should have classified as production-risk.
- Owner production approval gate: no exact `разрешаю отгрузку на прод` phrase for this release.
- Browser/user acceptance gate: test UI proof was not complete before release-impacting action.

## 5 Whys

1. Why did production risk happen? A test-only PR was merged into `master`.
2. Why was `master` allowed? The route treated PR merge/static checks as enough evidence.
3. Why was static evidence enough? No mandatory workflow impact audit blocked branch/workflow actions.
4. Why was the test/prod boundary weak? Workflow names and task text were trusted more than branch/YAML/environment facts.
5. Why did rollback not prove safety? Rollback corrected state after impact; it did not prevent the unsafe path.

## FMEA

| Failure mode | Effect | Severity | Control |
|---|---|---:|---|
| Test task merges to `master` | Production deploy risk | 10 | Block `main`/`master` unless release gate passes |
| Workflow name says test but YAML deploys | False safe route | 9 | Mandatory YAML impact audit |
| Unknown environment | Hidden prod impact | 9 | Treat unknown as production risk |
| Owner urgency words treated as approval | Unauthorized prod release | 10 | Exact phrase gate only |
| Workflow success treated as user proof | Fake Done | 8 | Browser/owner acceptance proof gate |
| Rollback treated as safety | Recurrence risk | 8 | Incident controls plus release candidate receipt |

## Blast Radius

Known changed production-risk path: PR #154 changed two files and was rolled back by PR #155. Exact live production user impact is UNKNOWN from repository evidence alone. No further production action was performed by this AH-794 correction run.

## Architecture Decision

Options considered:

A. Control-spine-only governance package.
B. Control-spine plus product-repo workflow guard PRs.
C. Full GitHub environment/branch protection + workflow guard + AgentHub route gate.

Selected now: A, control-spine-only package. It is the least risky durable mutation available in this task because StroyRemont repository guard changes were not explicitly included as a write scope. B/C are recommended follow-up gates for owner/admin execution, not performed here.
