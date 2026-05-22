---
artifact_id: AH-495-org-control-spine-migration-receipt
artifact_type: migration-receipt
owner_role: Verifier
source_task: AH-495
created_at: 2026-05-22
supersedes: AH-494-github-repo-setup-receipt
status: active
---

# AH-495 Organization-Only Control Spine Migration Receipt

## Scope

Move canonical AgentHub control-spine usage to the corporate GitHub organization namespace.

## Canonical Repository

- Owner: `arwoxbx24`
- Repository: `arwoxbx24/agenthub-control-spine`
- Visibility: private
- Personal owner `arwoxb24` is forbidden by default for future AgentHub control-spine work.

## Source Handling

The accidental personal repository was used as read-only scaffold source material only.

No delete, archive, rename, transfer, PR, issue, commit, or push was performed in the personal repository during AH-495.

## Validation

- Corporate repository exists.
- Bridge artifact exists at `governance/AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt`.
- `AGENTS.md` contains the org-only policy.
- `INDEX.md` references the bridge artifact.
- `runbooks/chatgpt-github-connect.md` points to `arwoxbx24/agenthub-control-spine`.
- YouTrack remains the task system.
- GitHub remains an artifact spine, not runtime infrastructure.

## Residuals

None if main branch readback confirms the files above after merge.
