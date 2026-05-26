---
artifact_id: codex-core-version-control-policy
artifact_type: governance-policy
owner_role: T1 Architect / Registrar
source_task: AH-570
run_id: RUN-P0-system-permission-core-versioning-20260526
created_at: 2026-05-26
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Codex / AgentHub Core Version-Control Policy

## Release Identity

AgentHub-core releases use:

`agenthub-core.YYYYMMDD.N`

This package installs `agenthub-core.20260526.1`.

Application releases use app-specific semantic versions and must not be mixed
with AgentHub-core governance versions.

## Allowlisted Core Surfaces

The following can be committed when task-bound, redacted, and reviewed:

- governance policies;
- schemas;
- runbooks;
- prompt templates;
- skill definitions;
- validator definitions;
- routing templates;
- model/cost policies;
- sanitized core manifests;
- eval fixtures;
- receipts and audit reports.

## Forbidden Raw Surfaces

Never commit raw:

- `/root/.codex` dumps;
- caches;
- raw transcripts;
- shell histories;
- `.env` files;
- tokens, keys, cookies, passwords;
- runtime configs;
- service logs;
- Docker/DB/proxy data;
- browser profiles.

For non-committable surfaces, store path class, redacted hash, owner role, and
change reason only.

## Checkpoint Model

Use compact checkpoint commits:

1. architecture and policy files;
2. hooks/validators/schema changes;
3. eval evidence and registers;
4. final receipt/readback.

Do not create commit spam for every micro-action.

## Branch And PR Rules

- Use one branch per scope signature.
- Do not create a duplicate PR while an open PR covers the same scope.
- Register each artifact in `INDEX.md` and `ARTIFACT_REGISTER.md`.
- Record queue state in `PR_QUEUE_REGISTER.md`.

## Rollback Rule

Each core release receipt must include:

- release id;
- source task;
- branch;
- PR or commit;
- changed control surfaces;
- rollback commit or tag;
- eval result;
- receipt path;
- YouTrack readback.

Rollback restores the last validated release and quarantines the failed prompt,
policy, or hook that caused the loop.
