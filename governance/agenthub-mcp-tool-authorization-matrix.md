---
artifact_id: agenthub-mcp-tool-authorization-matrix-20260611
artifact_type: governance_matrix
source_task: AH-745
run_id: RUN-AGENTHUB-BLOCKER-INVERSION-SCOPED-SELF-HEALING-20260611
status: active
---

# AgentHub MCP Tool Authorization Matrix

## Official Basis

MCP tools are discoverable and callable through tool metadata and tool call routes. Sensitive operations require authorization, scoped identity, auditability, and consent controls.

## Matrix

| Lane | MCP operation | Allowed when | Receipt required |
|---|---|---|---|
| 0 | read status/context | task-bound read-only | status receipt |
| 1 | artifact/register tools | control-spine task | artifact receipt |
| 2 | YouTrack issue update/move | issue id and field schema readback | stage receipt |
| 3 | GitHub branch/PR/file | repo/branch scope and duplicate check | commit/PR receipt |
| 4 | tool discovery/route repair | missing route or stale tool metadata | auth receipt |
| 5 | live service worker | scoped T2 route, rollback, validation | runtime receipt |
| 6 | destructive operation | replacement/backup/explicit owner proof | destruction receipt |

## Missing Tool Rule

A missing tool is repaired or converted to a typed platform repair item. The same failed tool call must not loop more than twice.
