---
artifact_id: AH-507-chatgpt-control-app-bootstrap-receipt
artifact_type: receipt
owner_role: T0 Control Plane
source_task: AH-507
run_id: AH-CHATGPT-APP-BOOTSTRAP-20260523
status: partial
---

# Receipt: AgentHub ChatGPT Control App Bootstrap

Status: PARTIAL

## Evidence

- RUN_ID: `AH-CHATGPT-APP-BOOTSTRAP-20260523`
- YouTrack task: `AH-507`
- Repository: `arwoxbx24/agenthub-control-spine`
- Branch: `agenthub/AH-507-chatgpt-control-app`
- App skeleton path: `apps/agenthub-chatgpt-control-app/`
- Source map: `reports/apps/AH-507-source-map.md`
- ADR: `reports/apps/AH-507-chatgpt-control-app-adr.md`
- Validation plan: `reports/apps/AH-507-validation-plan.md`
- Prompt artifact: `prompts/apps/AH-507-chatgpt-control-app-implementation-prompt.md`
- Write-proof status artifact: `reports/write-proof/AH-507-chatgpt-control-app-write-proof.md`

## Implemented Tool Surface

- `health_check`
- `list_allowed_repositories`
- `read_control_spine_file`
- `create_control_spine_artifact`
- `update_control_spine_artifact`
- `github_write_proof`
- `create_branch_commit_pr`
- `merge_pull_request_controlled`
- `create_or_update_youtrack_task`
- `create_or_update_y_outrack_task`
- `record_receipt`

## Safety Controls

- Default owner restricted to `arwoxbx24`.
- Canonical write repository restricted to `arwoxbx24/agenthub-control-spine`.
- Personal owner `arwoxb24` blocked by default.
- Secret-like paths, env files, private keys, raw transcripts, path traversal,
  and arbitrary write prefixes are blocked.
- Repository deletion tool is absent.
- Merge tool intentionally blocks until approval and status-check gates are
  implemented.
- Audit log redacts token-like values.

## Local Validation

- `npm ci`: PASS, npm audit summary reported `0` vulnerabilities.
- `npm test`: PASS, TypeScript build plus 5 policy tests.
- `npm run test:static`: PASS, executable source scan found no repository
  deletion API surface and no committed token pattern.
- `gitleaks detect --redact`: PASS, findings `0`.
- Redacted report: `@artifacts/AH-CHATGPT-APP-BOOTSTRAP-20260523/gitleaks-redacted-final.json`.

## Blockers

- `BLOCKER_PUBLIC_HTTPS_MCP_ENDPOINT_MISSING`
- `BLOCKER_CHATGPT_DEVELOPER_MODE_UNAVAILABLE`
- `BLOCKER_GITHUB_APP_CREDENTIAL_ROUTE_MISSING`

## Done Gate

PASS is not claimed. Full completion requires a real ChatGPT connector, visible
tool list, successful `health_check`, successful owner-restricted repository
listing, successful `github_write_proof` through this app's own tool path, and
receipt update with final evidence.
