---
artifact_id: owner-input-validation-priority-guard-runbook
artifact_type: runbook
source_task: AH-803
lifecycle: active_control_candidate
default_load: false
safe_to_replay: false
---

# Owner Input Validation Priority Guard Runbook

1. Classify the owner message before action.
2. Apply priority hierarchy: system/developer, project, source artifacts, control-spine policy, current task/run, owner message.
3. If unsafe or conflicting, reject only the unsafe/conflicting part and route the nearest safe scoped action.
4. Convert broad access requests into permission lanes with task, run, repo, path, tool, operation, expiry, rollback, evidence.
5. Convert communication preferences into compact action-bound messages.
6. Treat owner factual claims as investigation input until route/readback evidence exists.
7. Deny fake Done, owner shell handoff, local-only closure, and hidden material gates.
8. Validate with `owner_input_validation_priority_guard_validator.rb` before closure.
