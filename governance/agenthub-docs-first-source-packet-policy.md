---
artifact_id: agenthub-docs-first-source-packet-policy
artifact_type: governance-policy
owner_role: T1 Architecture Broker / Docs Worker
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Docs-First Source Packet Policy

Every task touching a product, API, CLI, model, framework, service, integration, or browser test must attach a Docs Packet before design or mutation.

## Required packet fields

- product or service name
- official docs URL
- docs version or visible page family
- retrieval timestamp
- applicable sections
- exact claims supported
- stale-risk note
- confidence
- fallback if docs are unavailable

## Official-source priority

Use official OpenAI docs for Codex/OpenAI facts, JetBrains docs for YouTrack, GitHub docs for GitHub/VCS behavior, modelcontextprotocol.io for MCP, Docker docs for Compose/profiles, and Playwright docs for browser assertions.

## Gate

No task may move to Preview with product/API/tool claims unless `DOCS_SOURCE_PACKET_PASS` is present or a same-RUN `DOCS_ACQUISITION_PACKFIX_REQUIRED` event is open.
