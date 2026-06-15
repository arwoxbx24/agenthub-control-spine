---
artifact_id: AH-803-task-service-summary-hygiene-validation-20260615
artifact_type: validation-report
source_task: AH-803
run_id: cleanup-stale-contours-20260615
created_at: 2026-06-15
lifecycle_status: validation-report
default_load: false
safe_to_replay: false
---

# AH-803 Task-Service Summary Hygiene Validation

Validator command:

```bash
ruby validators/task_service_summary_hygiene_validator.rb fixtures/task-service-summary-hygiene/fixtures.json
```

Expected result:

```json
{"status":"PASS","cases":7,"validator":"task_service_summary_hygiene_validator.rb"}
```

Coverage:

- rejects `Task-service backlog request` for unresolved tasks;
- rejects empty/untitled summaries;
- rejects Done without implementation evidence, validation evidence, and receipt;
- rejects duplicate microtasks without parent or duplicate signature;
- allows meaningful active tasks;
- allows stale cleanup tasks only with evidence and no-blocker marker.
