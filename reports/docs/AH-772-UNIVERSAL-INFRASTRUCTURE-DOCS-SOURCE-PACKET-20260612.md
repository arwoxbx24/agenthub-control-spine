---
artifact_id: ah-772-universal-infrastructure-docs-source-packet-20260612
artifact_type: docs_source_packet
source_task: AH-772
run_id: RUN-AGENTHUB-UNIVERSAL-INFRASTRUCTURE-SCOPE-BROKER-20260612
created_at: 2026-06-12
retrieved_at: 2026-06-12T17:50:00Z
lifecycle_status: active_evidence
---

# AH-772 Universal Infrastructure Docs Source Packet

## Purpose

This packet supports generic AgentHub infrastructure controls. It is not service-specific and must not treat any one service as the universal model.

## Official Sources Checked

| Product | Official URL | Claim Supported |
| --- | --- | --- |
| Docker Compose | https://docs.docker.com/compose/how-tos/project-name/ | Compose project names provide isolation boundaries for sandbox/rehearsal environments. |
| Docker Compose | https://docs.docker.com/compose/how-tos/profiles/ | Compose profiles support selective service activation for environment/use-case specific runs. |
| Docker Compose | https://docs.docker.com/reference/compose-file/services/#healthcheck | Service healthcheck entries are valid container health evidence surfaces. |
| MCP | https://modelcontextprotocol.io/specification/2025-06-18/server/tools | MCP tools can expose powerful operations and need clear tool contracts. |
| MCP | https://modelcontextprotocol.io/docs/tutorials/security/authorization | Authorization controls protect sensitive/admin operations and resources. |
| YouTrack | https://www.jetbrains.com/help/youtrack/devportal/youtrack-rest-api.html | YouTrack REST API supports task automation/readback. |
| YouTrack | https://www.jetbrains.com/help/youtrack/server/integration-with-version-control-systems.html | VCS integration supports linking task work to repository activity. |
| OpenAI Codex | https://developers.openai.com/codex/config-basic | Codex config covers model, approval, sandbox, MCP servers, and project settings. |
| OpenAI Codex | https://developers.openai.com/codex/agent-approvals-security | Scoped approval/sandbox behavior is the supported safety model; broad bypass is not the global answer. |

## Applicability

Use this packet for generic infrastructure governance and for routing future service-specific jobs into their own docs packets. Each concrete service still needs its own official docs source before mutation.

## Stale Risk

Medium. Platform behavior and tool permissions can change; refresh the relevant official docs packet inside each new RUN before live mutation.