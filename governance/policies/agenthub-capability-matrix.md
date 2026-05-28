---
artifact_id: agenthub-capability-matrix
artifact_type: active_policy
owner_role: T1 Architect / Capability Controller
source_task: AH-590
run_id: RUN-P0-SELF-HEALING-CORE-20260528
created_at: 2026-05-28
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Capability Matrix

## Rule

No action may execute unless role, surface, operation, required model, authority
level, and gates are present and valid. A missing matrix field is
`POLICY_DEFECT_CAPABILITY_FIELDS_MISSING`, not permission to guess.

## Roles

| Role | Allowed purpose | Forbidden |
|---|---|---|
| `T0_CONTROL` | intake, classify, bind RUN/task, route, verify receipts, open self-healing events, final owner summary | code, shell, Linux, Docker, proxy, DB, firewall, DNS, product files, service restarts, secrets values |
| `T1_ARCHITECT` | policy design, ADRs, schemas, runbooks, scoped worker-profile approval | production/runtime mutation |
| `T2_CODEX_WORKER` | code/config/YAML/schema/eval/control-spine implementation after authorization | unassigned surfaces, non-Codex route when Codex is available, secrets printing |
| `T2_DEVOPS_WORKER` | bounded runtime read or mutation only with exact live profile and rollback | broad prune/delete, DB/proxy/firewall without exact gate |
| `T2_REGISTRAR` | INDEX, ARTIFACT_REGISTER, PR_QUEUE_REGISTER, receipt/readback patches | runtime/product mutation |
| `T2_SECRET_HANDLE_REGISTRAR` | redacted secret-handle metadata and owner acquisition guides | secret values, raw env dumps |
| `VERIFIER` | read-only validation and evidence checks | mutation |
| `REGISTRAR` | lifecycle and PR/task queue readback | runtime/product mutation |

## Surfaces

Allowed surface ids:

- `control_spine_repo`
- `YouTrack`
- `AgentHub_lifecycle`
- `Codex_model_route`
- `Docker_read`
- `Docker_write`
- `NPM_read`
- `NPM_write`
- `DNS_read`
- `DNS_write`
- `YandexCloud_read`
- `YandexCloud_write`
- `S3_read`
- `S3_write`
- `DB_read`
- `DB_write`
- `product_repo`
- `production_runtime`
- `secrets_manifest`
- `secret_values`

## Operations

- `read`
- `write_artifact`
- `patch_register`
- `create_task`
- `update_task`
- `dispatch_worker`
- `install_policy`
- `validate_policy`
- `run_code_model`
- `runtime_read`
- `runtime_mutate`
- `external_api_read`
- `external_api_write`

## Required Gates

Every authorization receipt must include:

- `task_id`
- `run_id`
- `source_of_truth`
- `allowed_surfaces`
- `forbidden_surfaces`
- `rollback_if_mutation`
- `secret_redaction`
- `evidence_path`
- `validation_plan`
- `owner_only_check`
- `model_route`

## Matrix Entries

| Role | Operation | Surface | Required model/tool route | Authority | Required outcome |
|---|---|---|---|---|---|
| `T0_CONTROL` | `dispatch_worker` | `AgentHub_lifecycle` | control route | control-only | `ALLOW_CONTROL_ROUTE` |
| `T0_CONTROL` | `runtime_mutate` | any runtime surface | none | denied | `BLOCKED_T0_DIRECT_RUNTIME_ACTION` |
| `T0_CONTROL` | `write_artifact` | `control_spine_repo` | none | denied | `BLOCKED_T0_DIRECT_AUTHORSHIP` |
| `T1_ARCHITECT` | `install_policy` | `control_spine_repo` | architecture route | policy author | `ALLOW_POLICY_ARCHITECTURE` |
| `T2_CODEX_WORKER` | `run_code_model` | `control_spine_repo` | Codex primary, same-RUN Codex fallback only | scoped worker | `ALLOW_CODEX_AUTHORIZED_WORKER` |
| `T2_REGISTRAR` | `patch_register` | `control_spine_repo` | deterministic or low-cost registrar route | scoped registrar | `ALLOW_REGISTRAR_PATCH` |
| `T2_SECRET_HANDLE_REGISTRAR` | `write_artifact` | `secrets_manifest` | registrar route | metadata-only | `ALLOW_SECRET_HANDLE_METADATA` |
| `VERIFIER` | `validate_policy` | assigned evidence | verifier route | read-only | `ALLOW_READONLY_VERIFY` |
