---
artifact_type: queue-event-template
source_task: AH-P0-NO-INTERACTION-TASK-FIRST
status: active
---

# RUN_USER_INPUT_QUEUE Event Template

```json
{
  "event_id": "",
  "run_id": "",
  "task_id": "",
  "received_at": "",
  "active_state": "ACTIVE_RUN",
  "classification": "SCOPE_REINFORCEMENT",
  "message_hash": "",
  "routing_action": "append_to_current_context_and_continue",
  "affected_child_task": "",
  "user_reply_allowed": false,
  "terminal_state": "",
  "evidence_ref": ""
}
```

Do not store raw angry text, secrets, credentials, long logs, or internal links in
the queue event. Store a hash and a neutral classification.
