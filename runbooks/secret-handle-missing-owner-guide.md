---
artifact_id: secret-handle-missing-owner-guide
artifact_type: runbook
owner_role: Security Controller
source_task: AH-590
run_id: RUN-P0-GLOBAL-AGENT-CONTROL-SECRETS-REPO-AUDIT-20260527
created_at: 2026-05-27
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# Secret Handle Missing Owner Guide

Use this only when an authorized worker needs a secret handle and the redacted manifest has no usable handle.

Owner-facing form:

`Блокер: SECRET_HANDLE_MISSING. Нужно добавить handle для <provider>/<service>: <exact credential class>, scope <task/surface>, без отправки значения в чат.`

Rules:

- do not ask for broad server access;
- do not ask the owner to paste raw values into chat;
- do not scan arbitrary files;
- do not proceed through T0 shell;
- record a redacted task receipt and wait for handle installation.
