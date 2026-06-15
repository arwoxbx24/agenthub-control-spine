---
artifact_id: protected-link-agenthub-route-packfix-policy
artifact_type: governance-policy
source_task: AH-800/AH-802
prompt_id: AGENTHUB-THREE-OPEN-FAULTS-TERMINAL-CLOSURE-20260615
lifecycle: active_control_candidate
default_load: false
safe_to_replay: false
---

# Protected-Link AgentHub Route PackFix Policy

## Purpose

Ensure protected links are handled through AgentHub tool lanes instead of owner text-paste requests, public browser bypasses, or curl/wget fallback.

## Required Route

For protected links matching `https://b244.ru/...`, `https://io.b244.ru/...`, `b244://...`, Google Drive/Docs/Sheets/Slides, or configured protected storage links:

1. Run `agent_link_intake` for the requested intent.
2. Run `agent_link_resolve` or the intake-integrated read/verify tool when applicable.
3. For local protected artifacts, use `agent_link_read` or `agent_link_verify`.
4. For unresolved but retrieval-authorized links, use `agent_download` with the intake-approved URL or protected download id.
5. If the route fails, create same-RUN PackFix and continue through a registered lane.

## Hard Denials

- No owner text-paste request for routine protected-link failures.
- No public browser/open/curl/wget bypass unless a future approved tool lane records evidence and redaction.
- No raw secret, token, cookie, environment, or private artifact content in owner chat.
- No Done from visible owner browser success alone; AgentHub protected route readback is required.

## Done Gate

Protected-link row is green only when an approved route reads/verifies the material, or a reusable PackFix route is installed, validated, and task readback records the exact residual as owner-only or source-missing.
