---
artifact_id: workspace-codex-directory-governance-architecture-map-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# Architectural Directory Map

## Source Of Truth

- `@workspace/projects/agenthub-control-spine`: canonical repo.
- `@runtime/`: AgentHub/Codex runtime implementation and contracts.
- `@runtime-root/AGENTS.md` and root AGENTS policy: current runtime policy layer.
- YouTrack `AH-786`: audit task state.

## Runtime Directories

- `@runtime/runtime-state`: hook and gate receipts.
- `@agenthub-state/runs`: run outputs and worker sandboxes.
- `@runtime-root/sessions`, `@runtime-root/log`, `@runtime-root/cache`: volatile/private runtime data.

## Transient Directories

- `@runtime-root/.tmp`, `@runtime-root/tmp`, `@runtime-root/cache`, plugin staging folders.
- `@agenthub-state/runs/*` with retry/final/patch naming.

## Forbidden Final Artifact Locations

- `/tmp` or equivalent temp roots.
- `@workspace/projects/*` non-control-spine project roots for AgentHub proof artifacts.
- `@runtime-root/sessions`, logs, caches, run sandboxes.
- DB/proxy/Docker/firewall/service folders.

## Allowed Final Artifact Locations

- Control-spine audit branch under `reports/audits/...`.
- Control-spine registers when lifecycle coverage is in scope.
- AgentHub runtime receipts only as operational evidence, not final docs.

## Governance Decision Needed

Install write-location guard: final docs/reports/receipts must land in canonical repo branch or registered artifact store, never random project/runtime folders.
