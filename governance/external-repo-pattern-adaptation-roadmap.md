---
artifact_id: external-repo-pattern-adaptation-roadmap
artifact_type: architecture-decision
owner_role: T0 Registrar
source_task: AH-530
run_id: RUN-external-pattern-adaptation-closure-20260524
created_at: 2026-05-24
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# External Repository Pattern Adaptation Roadmap

## Decision

AgentHub will adapt patterns from the completed AH-527 research only. It will
not install, execute, vendor, import, or run
`anthropics/knowledge-work-plugins` or `microsoft/AI-Engineering-Coach`.

Selected path: pattern adaptation into AgentHub control-spine artifacts and
future scoped implementation tasks.

## Source Readback

- AH-527 report: `reports/research/external-agent-framework-pattern-audit-20260524.md`
- AH-527 receipt: `reports/receipts/external-agent-framework-pattern-audit-receipt-20260524.md`
- PR `#26`: merged research package.
- PR `#27`: merged research register/queue cleanup.

## Adaptation Tracks

| Track | YouTrack task | Brief | Scope |
|---|---|---|---|
| Anthropic-style plugin/command/connector/skill catalog | AH-531 | `prompts/implementation/anthropic-knowledge-work-pattern-adaptation-worker.txt` | AgentHub-local skill-pack and connector declaration patterns. |
| Microsoft-style anti-pattern/context-health/token/session evals | AH-532 | `prompts/implementation/microsoft-ai-engineering-coach-pattern-adaptation-worker.txt` | AgentHub-local evaluator and Registrar hygiene patterns. |

Parent tracking task: AH-530.

## Rules

1. External repositories are pattern sources only.
2. Do not copy external source files into AgentHub runtime.
3. Do not install Claude plugins, VS Code extensions, VSIX packages, MCP
   connector configs, local log analyzers, or marketplace tooling.
4. Do not parse raw session logs, raw transcripts, private prompts, secrets, or
   developer local storage without a separate privacy/security task.
5. Future workers may create only AgentHub-local artifacts with attribution to
   the AH-527 research and with lifecycle metadata.
6. Future implementation must stay under YouTrack tasks AH-531 and AH-532 or
   explicit successors.
7. Done requires implementation evidence, validation evidence, receipt,
   register coverage, and no active blocker.

## Acceptance For Future Implementation

Anthropic track acceptance:

- AgentHub-local skill-pack manifest or equivalent specification exists.
- Skill/command/connector separation is represented without external runtime
  dependency.
- Connector declarations point to approved AgentHub MCP route requirements, not
  copied external configs.
- Register lifecycle rules classify external examples as `audit_only` until
  adapted and reviewed.

Microsoft track acceptance:

- AgentHub-local prompt/eval rule structure exists.
- Context-health, token-cost, session-quality, skill-discovery, and anti-pattern
  checks run on redacted receipts/register metadata, not raw logs.
- False positives and privacy limits are documented.
- Eval results cannot become Done proof by themselves.

## Rejected Paths

- Runtime install of either repository.
- Vendor import of external repository code.
- GitHub Issues as task system.
- Broad research loop without implementation brief ownership.
- Report-only closure for future implementation tasks.
