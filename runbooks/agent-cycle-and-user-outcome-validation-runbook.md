---
artifact_id: agent-cycle-and-user-outcome-validation-runbook
artifact_type: runbook
source_task: AH-788
run_id: permanent-user-outcome-validation-governance-20260613
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Agent Cycle And User-Outcome Validation Runbook

## Intake

Create or reuse one YouTrack task, one RUN_ID, one branch, and one PR for the scope signature. Search duplicates first.

## Matrix Selection

Declare each row as `PASS`, `NOT_APPLICABLE`, `DEFECT`, or `BLOCKED`:

1. task binding;
2. source/control binding;
3. scope and role routing;
4. static governance validation;
5. policy/schema validation;
6. unit/eval fixture validation;
7. integration validation;
8. route/permission validation;
9. runtime/service validation;
10. browser/user-story validation;
11. test-account/data validation;
12. security validation;
13. directory governance validation;
14. Git/VCS validation;
15. YouTrack Done validation;
16. final readback.

Rows not in scope must state why.

## Blind Retry Handling

After first failure, read exact error, validator, regex, schema, or hook source. Apply one canonical correction. If the same gate fails twice, create a typed architecture defect. Do not mutate new folders or ask owner for routine route gaps.

## Browser/User-Story Evidence

For user-visible scope, capture expected user path, route, status, screenshot/trace when useful, backend/API state when relevant, and negative duplicate/regression check. Test accounts and test data need scoped cleanup or retention notes and no secret values in receipts.

## Closure

Do not move Stage Done until the task has exact Done markers, receipt path, PR/register coverage, no blocker, and readback.
