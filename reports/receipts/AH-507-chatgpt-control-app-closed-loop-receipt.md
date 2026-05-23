---
artifact_id: AH-507-chatgpt-control-app-closed-loop-receipt
artifact_type: corrective-incident-receipt
owner_role: T0 Control Plane
source_task: AH-507
run_id: AH-507-CHATGPT-CONTROL-APP-CLOSED-LOOP-20260523
status: blocked
---

# AH-507 Closed Loop Receipt

Status: `BLOCKED`

Typed blocker: `BLOCKER_PUBLIC_MCP_URL_REQUIRES_APPROVED_HOSTING`

## Scope Verification

- Canonical repository: `arwoxbx24/agenthub-control-spine`.
- Personal owner `arwoxb24`: not used.
- YouTrack task: reused `AH-507`; no new task created.
- Existing AH-507 PRs found:
  - PR #7: merged, merge commit `5838bd9c0ff7ea8966f33d269093daba37ee73b0`.
  - PR #8: merged, merge commit `bd7c2d51dfe127f4505a3dadc2129c750949f126`.
- Corrective branch for this receipt: `agenthub/AH-507-closed-loop-receipt`.
- Railway/external hosting/tunnel/prod infrastructure: not touched during this corrective receipt pass.

## Fact Check

| Gate | Status | Evidence |
|---|---|---|
| `AGENTS.md` read | PASS | Repository policy read before receipt update. |
| `INDEX.md` read | PASS | Artifact index read before receipt update. |
| Existing AH-507 state resumed | PASS | PR #7 and PR #8 inspected; no new task created. |
| `/sse` endpoint exists | PASS | `apps/agenthub-chatgpt-control-app/src/server.ts` imports `SSEServerTransport` and registers `GET /sse` plus `POST /messages`. |
| `/mcp` endpoint exists | PASS | `apps/agenthub-chatgpt-control-app/src/server.ts` registers `POST /mcp` via `StreamableHTTPServerTransport`. |
| Invalid legacy tool name removed | PASS | Space-containing `create_or_update_y outrack_task` is absent; MCP-safe `create_or_update_y_outrack_task` is present. |
| Repository deletion tool absent | PASS | Static source policy test passed. |
| Secret-like paths guarded | PASS | Policy tests passed. |
| Personal owner blocked | PASS | Policy tests passed. |
| ChatGPT public URL available | BLOCKED | ChatGPT Developer Mode requires a public HTTPS MCP URL; closed contour forbids Railway and no approved hosting/tunnel is available. |

## Validation Evidence

- `npm ci`: PASS; npm reported `0` vulnerabilities.
- `npm test`: PASS; TypeScript build plus 5 policy tests.
- `npm run test:static`: PASS; executable source scan found no repository deletion API surface or committed token pattern.
- Local `npm start`: PASS.
- Local `GET /healthz`: PASS.
- Local `GET /sse`: PASS; returned an SSE `/messages?sessionId=...` endpoint.
- Local `POST /mcp` initialize: PASS with required Accept header; returned MCP initialize result.
- `gitleaks detect --redact`: PASS; findings `0`.
- Redacted scan report:
  `@artifacts/AH-507-CHATGPT-CONTROL-APP-CLOSED-LOOP-20260523/gitleaks-redacted.json`.

## Closure Decision

Implementation inside the canonical repository is complete for the closed contour:
`/sse`, `/messages`, and `/mcp` are implemented and locally validated.

Full ChatGPT Developer Mode completion cannot be claimed because ChatGPT web must
reach a public HTTPS MCP URL. The only remaining action is selecting an approved
public HTTPS hosting/tunnel path inside the user's allowed contour.
