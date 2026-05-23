# AgentHub ChatGPT Control App

Status: prototype skeleton for AH-507.

This directory contains a tools-only Apps SDK / MCP connector for the AgentHub
control spine. It is designed for ChatGPT Developer Mode testing through a
public HTTPS `/mcp` endpoint, but it does not include production hosting or
secrets.

## Safety Model

- Default GitHub owner allowlist: `arwoxbx24`.
- Default control repository: `arwoxbx24/agenthub-control-spine`.
- Personal owner `arwoxb24` is blocked unless a future task adds explicit,
  scoped authorization.
- No repository deletion tool is exposed.
- Write tools validate path prefixes, block secret-bearing paths, and require a
  server-side credential route.
- Audit logs redact token-like values and store correlation-oriented metadata,
  not raw secrets or full chat transcripts.

## Environment

Set secrets only in approved server-side secret storage:

```text
GITHUB_TOKEN=...
YOUTRACK_BASE_URL=...
YOUTRACK_TOKEN=...
PORT=8787
```

`GITHUB_TOKEN` may be a GitHub App installation token or another approved
short-lived server-side credential. Do not store it in this repository.

## Local Validation

```bash
npm install
npm test
npm run test:static
```

Full PASS requires ChatGPT Developer Mode connection to a public HTTPS `/mcp`
endpoint and a safe write proof performed through this app's own
`github_write_proof` tool.
