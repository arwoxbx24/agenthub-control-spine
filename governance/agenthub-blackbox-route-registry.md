---
artifact_id: agenthub-blackbox-route-registry
artifact_type: active_control
owner_role: T1 Architect / Registrar
source_task: AH-594
run_id: RUN-P0-METHODOLOGY-ENFORCEMENT-CERTIFICATION-20260528
created_at: 2026-05-28
lifecycle_status: active_control
default_load: false
safe_to_replay: false
---

# AgentHub Black-Box Route Registry

Unregistered execution routes are denied. Registered routes still require
`RUN_ID`, `task_id`, role, surfaces, operation, evidence target, redaction, and
retry/self-repair gates before use.

## Gate Rules

- Unregistered execution route: `DENY_UNREGISTERED_ROUTE`.
- T0/TMLI/TeamLead using any runtime/CLI/code route:
  `DENY_T0_DIRECT_ACTION`.
- T1 using runtime mutation: `DENY_ARCHITECT_RUNTIME_ACTION`.
- Missing `RUN_ID`: `DENY_RUN_ID_MISSING`.
- Missing `task_id`: `DENY_TASK_ID_MISSING`.
- `target_surface` absent from `allowed_surfaces`: `DENY_SURFACE_NOT_ALLOWED`.
- `target_surface` present in `forbidden_surfaces`: `DENY_SURFACE_FORBIDDEN`.
- Missing repo receipt target: `DENY_NO_REPO_RECEIPT_TARGET`.
- Two same-gate failures: `STOP_RETRY_AND_SELF_REPAIR_POLICY`.

## Route Records

| route_id | owner_role | allowed_roles | forbidden_roles | allowed_operations | forbidden_operations | allowed_surfaces | forbidden_surfaces | evidence | status |
|---|---|---|---|---|---|---|---|---|---|
| `shell_direct` | T2 worker route | T2_CODEX_WORKER, T2_DEVOPS_WORKER | T0_CONTROL, T1_ARCHITECT | scoped read/script only | unscoped runtime mutate | assigned_repo, approved_runtime_read | DB_write, proxy_write, firewall, secret_values | repo receipt + redacted output | blocked by default |
| `language_runtime` | T2 worker route | T2_CODEX_WORKER | T0_CONTROL, T1_ARCHITECT | tests, validators, scripts | product mutation without scope | assigned_repo | secret_values, production_runtime | validator receipt | allowed when scoped |
| `docker_compose` | T2 DevOps route | T2_DEVOPS_WORKER | T0_CONTROL, T1_ARCHITECT | scoped read or approved restart | prune/delete/global mutate | Docker_read, scoped_service | Docker_write without rollback, DB_write | rollback + receipt | owner_only_gate for writes |
| `kubernetes_systemctl_service` | T2 DevOps route | T2_DEVOPS_WORKER | T0_CONTROL, T1_ARCHITECT | scoped service read/repair | broad restart/delete | production_runtime scoped service | global_host, secret_values | rollback + receipt | owner_only_gate |
| `git_gh_write` | Registrar route | REGISTRAR, T2_CODEX_WORKER | T0_CONTROL | branch, commit, PR, merge when task-bound | direct main write | control_spine_repo | product_repo, secret_values | PR + register receipt | allowed when scoped |
| `cloud_cli` | T2 DevOps route | T2_DEVOPS_WORKER | T0_CONTROL, T1_ARCHITECT | scoped read | mutate without owner gate | cloud_read | cloud_write, billing | redacted receipt | owner_only_gate for writes |
| `curl_http_api` | scoped route | T2_DEVOPS_WORKER, VERIFIER | T0_CONTROL | scoped read/health | mutation without contract | approved_api_read | secret_values, external_write | redacted receipt | blocked by default |
| `ssh_terminal` | T2 DevOps route | T2_DEVOPS_WORKER | T0_CONTROL, T1_ARCHITECT | scoped read/repair | unbound sessions | approved_host_scope | secret_values, unrelated_host | session ownership receipt | quarantine unless bound |
| `mcp_tool` | AgentHub MCP | T0_CONTROL, T1_ARCHITECT, T2_CODEX_WORKER, VERIFIER, REGISTRAR | none unless route contract denies | contract-declared operations | bypassing MCP with console fallback | declared MCP surface | undeclared surface | MCP receipt | allowed when scoped |
| `agenthub_adapter` | AgentHub MCP | T2_CODEX_WORKER, T2_DEVOPS_WORKER, VERIFIER, REGISTRAR | T0_CONTROL for direct runtime action | assigned worker execution | unscoped adapter command | assigned surface | forbidden task surface | dispatch/execute receipt | allowed when scoped |
| `browser_headless` | verifier route | VERIFIER, T2_CODEX_WORKER | T0_CONTROL for product mutation | UI validation | hidden data mutation | public/sandbox UI | secret_values, DB_write | screenshot/outcome receipt | allowed when scoped |
| `db_client` | T2 DevOps route | T2_DEVOPS_WORKER | T0_CONTROL, T1_ARCHITECT | explicitly approved read | writes/dumps by default | DB_read | DB_write, secret_values | owner/rollback receipt | owner_only_gate |
| `proxy_npm_dns_ssl` | T2 DevOps route | T2_DEVOPS_WORKER | T0_CONTROL, T1_ARCHITECT | explicitly approved read | writes/reloads by default | NPM_read, DNS_read | NPM_write, DNS_write, SSL_write | owner/rollback receipt | owner_only_gate |

All routes have `kill_switch=true`, `required_run_id=true`,
`required_redaction=true`, `repo_receipt_required=true`, and
`max_retries_before_self_repair=2`.

