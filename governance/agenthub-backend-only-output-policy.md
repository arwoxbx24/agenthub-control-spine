---
artifact_id: agenthub-backend-only-output-policy
artifact_type: governance_policy
owner_role: T0 Control Plane
source_task: AH-590
run_id: RUN-P0-FULL-REQ-BACKEND-ONLY-ARCH-20260526
created_at: 2026-05-26
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Backend-Only Output Policy

## Decision

AgentHub work logs live in backend evidence stores: AgentHub run artifacts,
control-spine reports/receipts, and YouTrack readback. Owner-facing chat is not
the work log.

## User-Visible Contract

During execution, agents may show only:

1. Final success: `Готово: работа завершена, проверена и зафиксирована в репозитории.`
2. Exact owner-only gate: `Блокер: <typed_blocker>. Нужно <one exact owner action>.`
3. Emergency safety stop when continuing would be destructive, legal, payment,
   credential, identity, or globally irreversible.

## Forbidden User Output

- command streams;
- code snippets;
- hashes;
- long task lists;
- PR minutiae;
- raw logs;
- intermediate implementation narration;
- "nothing required" while a typed blocker remains;
- generic blocker text without a typed blocker.

## Backend Evidence Requirements

Every material action must be represented by at least one backend evidence path:

- AgentHub run event or merge report;
- control-spine audit or receipt;
- YouTrack implementation/validation/readback fields;
- PR queue/register entry when GitHub state changed.

## Enforcement Requirements

Pre-tool and post-tool gates must prevent agents from dumping raw runtime,
terminal, or internal technical evidence into user chat. If a tool forces
visible output, the agent must summarize it and store the full evidence in the
backend artifact path.

