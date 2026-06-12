---
artifact_id: agenthub-secret-handle-docs-first-autorepair-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker / Authority Broker / Registrar / Verifier
source_task: AH-771
run_id: RUN-AGENTHUB-SECRET-HANDLE-DOCS-FIRST-AUTOREPAIR-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Secret-Handle Docs-First Autorepair Policy

Agents must not ask the owner for passwords, API keys, tokens, sessions, JWTs, or manual clicks as the first response.

## Required sequence

1. Read current task and RUN.
2. Read service/project guide and approved secret-handle registry metadata.
3. Read prior receipts for reusable auth handles.
4. Build official docs packet for the target service.
5. Create scope descriptor and authority envelope.
6. Resolve secret handle metadata without exposing raw values.
7. Probe auth through approved worker route and record redacted proof.
8. If missing, create same-RUN PackFix.
9. If all internal routes fail, create owner HTML mini-guide and typed owner-only blocker.

## Owner-only threshold

`OWNER_ONLY_SECRET_HANDLE_CREATION_REQUIRED` is allowed only after registry, docs, config metadata, receipts, and auth probe routes are exhausted and documented.

## Forbidden

No raw secret output, env dumps, JWTs, private keys, broad grep of secret paths, DB mutation to bypass missing API auth, broad restart/down/delete/prune, proxy/firewall/global infra mutation, or prompt-only Done.

## Komodo pattern

For `KOMODO_AUTH_HANDLE_MISSING`, create `PACKFIX_SECRET_HANDLE_RESOLUTION_REQUIRED`, build Komodo docs packet, resolve handle metadata, probe Komodo Core API, and only then perform exact schedule/procedure repair if supported by API and Lane 6 authority exists.

If no handle exists, create `reports/guides/<TASK_ID>-owner-auth-handle-guide-<date>.html`, keep the task open or owner-gated, and do not ask for credentials in free text.
