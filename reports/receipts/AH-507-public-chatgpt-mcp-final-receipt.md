---
artifact_id: AH-507-public-chatgpt-mcp-final-receipt
artifact_type: final-receipt
source_task: AH-507
run_id: AH-507-PUBLIC-ROUTE-AUTO-20260523
status: pass
---

# AH-507 Public ChatGPT MCP Final Receipt

Status: `PASS`.

## Public Endpoint

- Public MCP URL: `https://git.b244.ru/mcp`.
- Public SSE URL: `https://git.b244.ru/sse`.
- Public health URL: `https://git.b244.ru/healthz`.

## Validation Evidence

- Public HTTPS health check: PASS.
- Public MCP initialize: PASS.
- Public MCP tool discovery: PASS.
- Public `health_check` tool call: PASS.
- Public `list_allowed_repositories` tool call: PASS.
- Public `github_write_proof` tool call: PASS.
- Controlled write-proof PR: #12, merged.
- Write-proof artifact status: `created-by-app-tool`.
- Corrective implementation PR for existing artifact update: #11, merged.

## Safety Evidence

- Canonical owner: `arwoxbx24`.
- Canonical repository: `arwoxbx24/agenthub-control-spine`.
- Personal owner is not canonical.
- Railway was not used.
- Secrets were not returned by the app.
- Repository deletion surface remains absent.
