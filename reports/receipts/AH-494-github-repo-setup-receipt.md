---
artifact_id: AH-494-github-repo-setup-receipt
artifact_type: setup-receipt
owner_role: Verifier
source_task: AH-494
created_at: 2026-05-22
supersedes: none
status: superseded
---

# AH-494 GitHub Repository Setup Receipt

## Scope

Create one private GitHub repository for AgentHub/Codex prompts, audit reports, receipts, governance templates, local skill drafts, and ChatGPT-readable architecture notes.

## Repository

- Name: `agenthub-control-spine`
- Owner: personal GitHub user `arwoxb24`; superseded by AH-495 corporate migration
- Visibility: private
- Branch: `agenthub/repo-spine-setup-AH-494`
- Pull request: `#1`

## Validation

- Required top-level files exist: `README.md`, `AGENTS.md`, `GOVERNANCE.md`, `SECURITY.md`, `CHANGELOG.md`, `INDEX.md`.
- Required directories exist: `prompts/`, `reports/`, `governance/`, `skills-drafts/`, `schemas/`, `runbooks/`, `.github/`.
- JSON schemas parse.
- Scaffold secret/raw-link scan returned no matches.
- No AgentHub runtime, Railway, TimeWeb, MTProxy, Docker, DB, proxy, firewall, ports, Nginx, or production services were touched.

## Official Sources

- ChatGPT GitHub connection: https://help.openai.com/en/articles/11145903-connecting-github-to-chatgpt
- Codex AGENTS.md guidance: https://developers.openai.com/codex/guides/agents-md
- Codex Skills: https://developers.openai.com/codex/skills
- Reusable Codex skills: https://developers.openai.com/codex/use-cases/reusable-codex-skills
- Codex GitHub integration: https://developers.openai.com/codex/integrations/github

## Critical Critique

- This GitHub repository is an artifact spine, not a runtime control plane.
- It does not replace AgentHub gates, validators, receipts, or YouTrack task-service.
- ChatGPT web should use this repository to review and refine prompts/reports, not to mutate runtime blindly.
- GitHub Issues are not enabled as a second task system unless explicitly approved later.

## Residuals

Superseded by `reports/receipts/AH-495-org-control-spine-migration-receipt.md`.

The personal owner is not canonical for future AgentHub control-spine work.
