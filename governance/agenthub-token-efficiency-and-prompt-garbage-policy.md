---
artifact_id: agenthub-token-efficiency-and-prompt-garbage-policy
artifact_type: governance-policy
owner_role: T0 Registrar / Token Efficiency Profiler
source_task: AH-767
run_id: RUN-AGENTHUB-KANBAN-DOCS-SANDBOX-TOKEN-EFFICIENCY-HARDLOCK-20260612
created_at: 2026-06-12
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Token Efficiency And Prompt Garbage Policy

Target: reduce token and limit consumption by at least 25 percent without reducing correctness.

## Controls

1. Do not paste full prompts or receipts into chat.
2. Use artifact path plus hash for large source text.
3. Load only current context pack and exact task artifacts.
4. Stop third same-gate retry.
5. Reuse docs packets inside the same RUN unless stale.
6. Collapse duplicate prompts into one active control.
7. Mark consumed prompts `safe_to_replay=false` unless explicitly approved.
8. Use MICRO, STANDARD, INCIDENT, or FULL profile selection.
9. Reserve GPT-5.5 for architecture, audit, strategy, or escalation; use Codex/Spark-capable routes for code/config where available.
10. Produce owner output only at terminal state.

## Metrics

Track `tokens_per_done_task`, `duplicate_task_count`, `duplicate_pr_count`, `same_blocker_retry_count`, `prompt_dump_count`, `full_artifact_reload_count`, `docs_packet_reuse_count`, `time_to_done`, and `owner_chat_messages_per_task`.
