---
artifact_id: root-readme
artifact_type: repository-overview
owner_role: T1 Architecture Broker
source_task: AH-494
created_at: 2026-05-22
supersedes: none
status: draft
---

# AgentHub Control Spine

This private repository is the file-based control spine for AgentHub/Codex prompts, reports, receipts, governance templates, skill drafts, and ChatGPT-readable architecture notes.

It is not the AgentHub runtime repository. It is not a production service repository. It does not replace YouTrack as the task system.

## Consumers

- ChatGPT web: later connected by the user through the ChatGPT GitHub connector to review, refine, and design prompts or reports.
- Codex CLI / AgentHub workers: update versioned prompt/report artifacts through task-first work and validation receipts.

## Rules

- Every serious artifact must have a short metadata header.
- Every prompt/report must be indexed in `INDEX.md`.
- User-facing summaries stay short and Russian.
- Technical detail stays in files, not chat.
- No secrets, raw transcripts, env dumps, or internal history links.
- No fake success: reports need evidence, validation, residuals, and verifier status.

## Key Directories

- `prompts/`: audit, implementation, correction, architecture, incident, and reusable templates.
- `reports/`: audits, incidents, receipts, verifier notes, and bundles.
- `governance/`: durable rules and operating policies.
- `skills-drafts/`: draft local skill briefs before controlled installation.
- `schemas/`: JSON schemas for prompt artifacts, report receipts, and task cards.
- `runbooks/`: operator steps for ChatGPT GitHub connection, Codex CLI use, and prompt intake.

