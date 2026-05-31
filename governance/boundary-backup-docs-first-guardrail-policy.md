---
artifact_id: boundary-backup-docs-first-guardrail-policy
artifact_type: governance-policy
source_task: AH-P0-BOUNDARY-BACKUP-DOCS-FIRST
run_id: RUN-P0-BOUNDARY-BACKUP-DOCS-FIRST-20260531
status: active
default_load: false
safe_to_replay: false
---

# Boundary, Backup, And Docs/API-First Guardrail Policy

This policy blocks scope escape, blind mutation, unsafe backups, product-internal
patching before official mechanisms, and fake Done from non-live evidence.

## Scope Manifest Gate

Every mutating worker must attach a `SCOPE_MANIFEST` before the first write.

Required fields:

- `RUN_ID`
- `issue_id` or `task_id`
- `task_class`
- `role`
- `worker_id`
- `product_or_service`
- `objective`
- `READ_ALLOWED_ROOTS`
- `WRITE_ALLOWED_ROOTS`
- `EXEC_ALLOWED_COMMAND_CLASSES`
- `FORBIDDEN_ROOTS`
- `FORBIDDEN_COMMAND_CLASSES`
- `ACTIVE_RUNTIME_PATH_PROOF`
- `OFFICIAL_MECHANISM_DECISION`
- `BACKUP_PLAN`
- `ROLLBACK_PLAN`
- `VALIDATION_PLAN`
- `DYNAMIC_SCOPE_EXPANSION_POLICY`
- `NO_USER_CHAT_POLICY`
- `owner_only_gate_conditions`

Default forbidden roots:

- `/root/gemini-space`
- `/root/codex-space`
- `/tmp` for production implementation evidence
- `/var/lib/docker`
- `/var/lib/docker/overlay2`
- database data directories
- proxy, firewall, DNS, cert, key, and secret directories
- unrelated workspaces
- any parent above the declared service root

Default write roots are empty until T1 Architect approves exact files or
directories. Broad roots such as `/`, `/root`, `/opt`, `/var`, and parent
service trees are not valid write allowlists.

## Dynamic Scope Expansion

If a worker needs a new path, it must stop before writing and create
`SCOPE_EXPANSION_REQUEST` with:

- new path and mode;
- reason current scope is insufficient;
- live/mirror/backup/generated/vendor classification;
- official mechanism evidence;
- backup and rollback impact;
- blast radius;
- validation plan;
- T1 decision.

Search results, path existence, or prior worker edits are not approval.

## Backup And Rollback Gate

Mutation requires rollback evidence. Preferred order:

1. git branch, commit, or stash for repository files;
2. exact-file backup for small files;
3. official product export or backup;
4. snapshot or volume backup only with explicit scoped authority;
5. typed blocker when no safe rollback exists.

Minimum fields:

- original path and hash;
- backup path or rollback ref;
- restore procedure;
- size class;
- secret-redaction handling;
- rationale if only one backup is used for production/runtime.

Never copy unknown-size trees, Docker volumes, DB directories, cert/key stores,
or whole services without an explicit size proof and authority gate. Backups
over 100 MB require T1 approval. Backups over 1 GB require owner-only or
platform-approved backup gate.

## Docs/API-First Gate

Existing products, frameworks, Dockerized apps, vendor tools, SaaS-like panels,
and unknown surfaces must use official docs and official mechanisms before
internal edits:

1. official documentation;
2. official API;
3. official UI/admin panel;
4. official CLI or documented config command;
5. documented config file;
6. extension/plugin mechanism;
7. minimal source patch only after ADR approval;
8. direct DB mutation only with explicit emergency authority.

Docs are not required for trivial first-party syntax/typing/format fixes that
are fully covered by tests and do not alter external behavior.

## No Blind Mutation

Mutation is blocked when any of these are missing:

- current state proof;
- source of truth;
- official mechanism decision;
- canonical live target path proof;
- scope manifest;
- backup or rollback;
- expected diff/impact;
- validation plan;
- task evidence target;
- no-secret policy;
- forbidden-zone proof.

## Evidence Done Gate

Done cannot be claimed from:

- `/root/gemini-space`, `/root/codex-space`, `/tmp`, mirrors, backups, or
  sandbox-only outputs as production implementation;
- green curl only;
- homepage or login page only;
- unauthenticated 200/302;
- GitHub PR alone;
- YouTrack state alone;
- report text without installed controls.

Done requires implementation evidence, validation evidence, receipt, task
readback or exact task-service blocker, register/PR queue coverage where in
scope, and no-blocker marker.
