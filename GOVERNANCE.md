---
artifact_id: root-governance
artifact_type: governance-overview
owner_role: T1 Architecture Broker
source_task: AH-494
created_at: 2026-05-22
supersedes: none
status: draft
---

# Governance

This repository stores prompt/report governance artifacts. Enforcement still lives in AgentHub runtime gates, validators, YouTrack task-service readback, and Git provenance receipts.

## Critical Critique

- A GitHub repository does not replace AgentHub gates by itself.
- ChatGPT web must not edit runtime blindly; it should propose and refine prompts and reports.
- Codex/AgentHub executes changes through task-first controls.
- GitHub Issues must not become a second task system unless explicitly approved later.
- Repo-local AGENTS.md and skills improve consistency, but runtime enforcement still requires validators, receipts, task-service gates, and Git provenance.

## Baseline

The current accepted baselines include AH-432, AH-441, AH-448, and AH-473/AH-476. Future changes must preserve or explicitly supersede them under a new controlling task.

