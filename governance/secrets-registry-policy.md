---
artifact_id: secrets-registry-policy
artifact_type: governance_policy
owner_role: Security Controller / Registrar
source_task: AH-590
run_id: RUN-P0-GLOBAL-AGENT-CONTROL-SECRETS-REPO-AUDIT-20260527
created_at: 2026-05-27
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Secrets Registry Policy

## Decision

AgentHub uses per-service secret handles plus a redacted registry manifest. A single giant secrets file is rejected because it increases blast radius, access confusion, and accidental disclosure risk.

## Runtime Storage Rule

Secret values stay outside Git, owner chat, task descriptions, reports, receipts, logs, and command output. Approved runtime storage is a protected secrets root or provider-native secret store. The control-spine stores only metadata.

Allowed metadata:

- `secret_id`
- project/service/provider
- handle name
- path pattern or provider location class, not the value
- allowed roles and scopes
- owner gate status
- rotation status
- last verification timestamp
- validation method
- redaction proof

## Lookup Rule

Workers may request a secret handle only when their role, task, scope, and authority profile match the manifest. The lookup result exposes metadata and a scoped handle, not the secret value.

## Missing Handle Rule

When a required handle is missing, the worker must stop with `SECRET_HANDLE_MISSING`. It must not scan arbitrary directories, dump env files, read shell history, or ask the owner for broad access. The owner guide must state the provider/account/service and exact fields needed in two or three sentences.

## Official Source Anchors

- GitHub secret scanning: https://docs.github.com/en/code-security/secret-scanning
- GitHub Actions secrets: https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions
- Docker Compose secrets: https://docs.docker.com/compose/how-tos/use-secrets/
