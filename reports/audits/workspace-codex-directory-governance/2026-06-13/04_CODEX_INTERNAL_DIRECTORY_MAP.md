---
artifact_id: workspace-codex-directory-governance-codex-map-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# Codex Internal Directory Map

## Stable Config

- `@runtime-root/rules`: rules/config layer.
- `@runtime-root/skills`: local skills. Read selected `SKILL.md` only.
- `@runtime-root/plugins`: plugin bundles and cache; staging dirs are transient.
- `@runtime-root/architecture`: architecture decisions.
- `@runtime/orchestration/templates`, `schemas`, `validators`, `hooks`, `policies`: runtime control surfaces.

## Runtime / Volatile

- `@runtime-root/runtime-state`: hardlock/hook receipts.
- `@runtime-root/sessions`: session state; never expose raw.
- `@runtime-root/log`: logs; no full dumps.
- `@runtime-root/cache`: cache; not source of truth.
- `@runtime-root/generated_images`: generated assets; artifact lifecycle required.
- `@runtime-root/shell_snapshots`: shell state; treat as sensitive operational evidence.

## Read/Write Rules

- Read config/skills only when selected by task.
- Write runtime policy only through AgentHub governance route.
- Do not expose sessions/logs/raw history.
- Do not treat cache/staging/run output as permanent controls.

## Observed Concern

`.codex` combines config, plugins, logs, sessions, cache, generated assets, runtime state, and orchestration code. Agents need path taxonomy before writing or claiming evidence.
