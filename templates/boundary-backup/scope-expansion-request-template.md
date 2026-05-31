---
artifact_type: scope-expansion-request-template
source_task: AH-P0-BOUNDARY-BACKUP-DOCS-FIRST
status: active
---

# SCOPE_EXPANSION_REQUEST Template

- run_id:
- task_id:
- worker_id:
- current_scope_signature:
- requested_path:
- requested_mode: read | write
- path_class: live | mirror | backup | generated | vendor_owned | unknown
- reason_current_scope_insufficient:
- official_mechanism_evidence:
- backup_rollback_impact:
- blast_radius:
- validation_plan:
- t1_decision: pending | approved | rejected
- decision_reason:

No write is allowed until `t1_decision=approved` and `SCOPE_MANIFEST` is
updated.
