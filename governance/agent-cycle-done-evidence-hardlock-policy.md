---
artifact_id: agent-cycle-done-evidence-hardlock-policy
artifact_type: active_policy
source_task: AH-785
run_id: permanent-done-gate-hardlock-20260613
scope_signature: permanent_architecture_done_gate_hardlock_no_fake_done_no_temporary_patch_no_routine_owner_stop
lifecycle_status: current_policy
default_load: false
safe_to_replay: false
---

# Agent Cycle + Done Evidence Hardlock

This policy is a durable control-spine contract. It prevents fake Done, fabricated evidence, owner-interruption loops, temporary patching, and routine blocker stops. It is not a prompt-only instruction and not an emergency patch.

## Official Documentation Packet

Verified official-source anchors for current platform behavior and external control boundaries:

- OpenAI Codex sandboxing: https://developers.openai.com/codex/concepts/sandboxing
- OpenAI Codex agent approvals and security: https://developers.openai.com/codex/agent-approvals-security
- OpenAI Codex skills: https://developers.openai.com/codex/skills
- OpenAI Codex rules/configuration: https://developers.openai.com/codex/rules
- JetBrains YouTrack workflow rules: https://www.jetbrains.com/help/youtrack/server/workflow-rules.html
- JetBrains YouTrack state-machine rules: https://www.jetbrains.com/help/youtrack/devportal/state-machine-per-issue-type.html
- GitHub branch protection: https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule
- GitHub CODEOWNERS: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners

## Agent Cycle

Every AgentHub/Codex/YouTrack task must run this closed loop before a terminal state:

1. Capture owner intent, task IDs, RUN_ID, repository, branch, allowed scope, forbidden scope, success criteria, and source contour.
2. Classify TASK_CLASS, ROLE, ACTIVE_SKILLS, FORBIDDEN_SKILLS, SCOPE_SIGNATURE, and NEGATIVE_MATCHES. Missing classification is `WRONG_TASK_CLASS_BLOCKER`, not Done.
3. Bind to one physical YouTrack task after duplicate check. If a matching task exists, continue it.
4. Load minimal sources: AGENTS.md, INDEX.md, ARTIFACT_REGISTER.md, PR_QUEUE_REGISTER.md, current context pack, and exact active artifacts.
5. Route work: T0 controls intake, routing, verification, register/readback, and final decision only. Mutation needs a scoped worker with task ID, allowed files, rollback/checkpoint, and validation plan.
6. Execute inside the current contour. Do not jump contours while current contour lacks terminal evidence.
7. Validate real outcome, not only a low-level signal.
8. Classify blockers. Routine remediable blockers become same-RUN PackFix work.
9. Run PackFix until the route succeeds or the same gate fails twice, then create an architecture repair task. Routine blockers are never terminal.
10. Record receipt with real paths/aliases, task ID, RUN_ID, worker role, validation evidence, no-secret proof, and register coverage.
11. Update registers, task comments/stage, parent/child links, and PR queue when in scope.
12. Decide only one terminal state: `DONE_WITH_EVIDENCE`, `OWNER_ONLY_IRREVERSIBLE_GATE`, `FORBIDDEN_SCOPE_BLOCKER`, `SAFETY_QUARANTINE`, `INSTRUCTION_SOURCE_DRIFT`, or `WRONG_TASK_CLASS_BLOCKER`.
13. Use short Russian final output only after terminal decision. No progress report while the cycle is non-terminal.

## Done Evidence Tuple

A task can move to Done only when every field is present and verified:

- `implementation_evidence`: commit, diff, artifact path, deployed change, or exact installed non-code control.
- `validation_evidence`: relevant user/business outcome proof; PR, curl, sandbox, or status page alone is weak proof.
- `receipt_path`: timestamped receipt with RUN_ID, task ID, worker role, redaction/no-secret status.
- `task_readback`: YouTrack issue state, comments, links, and parent/child status verified after update.
- `register_coverage`: INDEX, ARTIFACT_REGISTER, PR_QUEUE_REGISTER when artifacts or PRs are in scope.
- `blocker_status`: `NONE` for Done.
- `redteam_done_gate`: `PASS` against fake Done, weak evidence, wrong task, scope creep, stale prompt replay, PR-tail risk, secret leak, and owner-action leak.
- `run_id`, `source_task`, `child_tasks_done`, `task_readback_ok`, and `register_coverage_ok`.

## Blocker Taxonomy

Allowed terminal blockers:

- `OWNER_ONLY_IRREVERSIBLE_GATE`: inaccessible credential, payment, legal/destructive/global infrastructure authority, non-delegable identity login, or explicit irreversible external action.
- `FORBIDDEN_SCOPE_BLOCKER`: requested mutation is outside approved scope or forbidden without exact authority.
- `SAFETY_QUARANTINE`: fabricated evidence, secret leak, wrong task class, stale prompt replay, or destructive route risk.
- `INSTRUCTION_SOURCE_DRIFT`: AGENTS.md, project sources, or registers conflict and cannot be safely resolved.
- `WRONG_TASK_CLASS_BLOCKER`: task class, role, skill set, scope signature, or negative matches are missing or wrong.

`ROUTINE_REMEDIABLE_BLOCKER` is not terminal. Missing validation route, browser route, worker route, task comment, register row, PR queue state, stale receipt, docs packet, or one failed model route becomes same-RUN PackFix.

## Hardlocks

- T0 direct mutation is invalid implementation evidence.
- Owner-closed is rejected unless the current owner message explicitly orders closure of that exact task.
- GitHub PR is not YouTrack Done.
- Green curl/status page is not product Done.
- Screenshot without authenticated user-outcome context is not product Done.
- Sandbox-only evidence is not production/user proof.
- Report-only or prompt-only output is not installed architecture.
- Temporary folders, `/tmp` patches, unregistered scripts, and ad hoc files are rejected as final implementation.
- Fake/synthetic IDs, invented receipts, unverifiable validation, and fabricated blocker data enter `SAFETY_QUARANTINE`.
- Stale `audit_only`, `historical_receipt`, `consumed_prompt`, `superseded`, or `quarantine` artifacts cannot load as active policy.

## PR Queue and Artifact Lifecycle

No new PR may be opened for the same `source_task` and `scope_signature` when an open PR already exists. Every PR must have queue state: `ready_to_merge`, `merge_blocked_platform_gate`, `stale_close_preserve`, `superseded_close_preserve`, `conflict_needs_rebase`, `unsafe_quarantine`, or `owner_only_gate`.

Reports, receipts, prompts, handoffs, transcripts, and incident notes default to `default_load=false`. Only active source, active policy, active schema, and current context artifacts may default load.

## Rollback

Governance changes must have rollback branch or checkpoint evidence. Reverting this package requires a new task that preserves the receipt and explains which downstream hardlock replaces it.
