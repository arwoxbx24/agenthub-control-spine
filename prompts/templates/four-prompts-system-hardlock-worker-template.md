---
artifact_id: four-prompts-system-hardlock-worker-template
artifact_type: worker-prompt-template
owner_role: T1 Architect / T2 Governance Worker
source_task: RUN-20260615-FOUR-PROMPTS-SYSTEM-ARCH
run_id: RUN-20260615-FOUR-PROMPTS-SYSTEM-ARCH
created_at: 2026-06-15
lifecycle_status: active_template
default_load: false
safe_to_replay: false
---

# Four Prompts System Hardlock Worker Template

Required header:

```text
TASK_CLASS:
ROLE:
ACTIVE_SKILLS:
FORBIDDEN_SKILLS:
SCOPE_SIGNATURE:
NEGATIVE_MATCHES:
TASK_ID:
RUN_ID:
ENVIRONMENT_CLASSIFICATION:
TEST_ONLY_PROOF:
WORKFLOW_IMPACT_AUDIT:
PROD_RELEASE_AUTHORIZATION:
INCIDENT_SIGNAL_STATUS:
ROLLBACK_LANE_STATUS:
PR171_GITLEAKS_GATE_STATUS:
REGISTER_COVERAGE_STATUS:
TASK_READBACK_STATUS:
```

Stop before mutation if any required field is blank.

## Contract

Apply the four prompts as one ordered system:

1. Primary test-first/prod incident hardlock.
2. Deploy-lock coverage supplement.
3. Owner-distress recovery supplement.
4. PR171/gitleaks point-fix gate.

Do not touch product code, production/test sites, workflow dispatch, databases,
proxy layer, container services, process manager, secrets, DNS, SSL, object
storage, or broad cleanup.

## Output

Return one evidence packet:

- changed files;
- validator command and result;
- fixture summary;
- register coverage;
- task/PR readback or typed blocker;
- no-forbidden-surface statement;
- final terminal state.

