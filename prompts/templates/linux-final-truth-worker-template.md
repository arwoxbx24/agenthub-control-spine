---
artifact_id: linux-final-truth-worker-template
artifact_type: prompt_template
owner_role: T1 Architect / T2 Worker / Verifier
source_task: AH-790
run_id: linux-final-truth-gate-20260613
created_at: 2026-06-13
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Linux Final Truth Worker Template

## Required Header

- TASK_CLASS:
- ROLE:
- RUN_ID:
- TASK_ID:
- SCOPE_SIGNATURE:
- ACTIVE_SKILLS:
- FORBIDDEN_SKILLS:
- USER_VISIBLE_SCOPE: true | false

## Evidence Contract

Final output must be generated from a Linux-visible claim ledger. ChatGPT browser context, owner chat, prior draft response, PR body, or agent self-report is not proof.

For each final claim, record:

- claim_id
- audience
- task_id
- run_id
- scope_signature
- required_evidence_class
- actual_evidence_path
- evidence_readback_status
- verdict
- allowed_in_final
- reason

Only `GREEN` + `PASS` + `allowed_in_final=true` claims may appear in final owner/client text.

## Browser Rule

If `USER_VISIBLE_SCOPE=true`, an approved browser-worker receipt is required. Local curl/process/socket evidence is supporting only and cannot close the task.

## Done Tuple

```text
Implementation evidence: <installed control/diff/artifact path>
Validation evidence: <validator/browser/API/readback proof path>
Receipt: <receipt path or route receipt>
Blocker: none
```

Stage Done is last. Pending/residual/missing-proof text blocks closure.

## Final Shape

Russian only, short. No logs, JSON, internal matrices, or unsupported claims.
