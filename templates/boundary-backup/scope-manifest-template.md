---
artifact_type: scope-manifest-template
source_task: AH-P0-BOUNDARY-BACKUP-DOCS-FIRST
status: active
---

# SCOPE_MANIFEST Template

```json
{
  "RUN_ID": "",
  "task_id": "",
  "task_class": "",
  "role": "",
  "worker_id": "",
  "product_or_service": "",
  "objective": "",
  "READ_ALLOWED_ROOTS": [],
  "WRITE_ALLOWED_ROOTS": [],
  "EXEC_ALLOWED_COMMAND_CLASSES": [],
  "FORBIDDEN_ROOTS": [
    "/root/gemini-space",
    "/root/codex-space",
    "/tmp",
    "/var/lib/docker",
    "/var/lib/docker/overlay2"
  ],
  "FORBIDDEN_COMMAND_CLASSES": ["DB_write", "Docker_data_mutation", "proxy_firewall_dns_mutation", "secret_dump"],
  "ACTIVE_RUNTIME_PATH_PROOF": "",
  "OFFICIAL_MECHANISM_DECISION": "",
  "BACKUP_PLAN": "",
  "ROLLBACK_PLAN": "",
  "VALIDATION_PLAN": "",
  "DYNAMIC_SCOPE_EXPANSION_POLICY": "request_before_write",
  "NO_USER_CHAT_POLICY": "buffer_during_active_run",
  "owner_only_gate_conditions": []
}
```
