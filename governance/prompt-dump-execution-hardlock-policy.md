---
artifact_id: agenthub-prompt-dump-execution-hardlock-policy-20260611
artifact_type: governance_policy
source_task: AH-744
run_id: RUN-AGENTHUB-PROMPT-DUMP-EXECUTION-HARDLOCK-20260611
status: active
---

# Prompt-Dump Execution Hardlock Policy

## Purpose

AgentHub, Codex, MCP, and task workers must execute prompt artifacts and correction contracts through the active task contour. Printing prompt bodies, corrected blocks, YAML contracts, plans, or instruction fragments as the final result is a prompt-dump defect.

## Required Behavior

- Bind to the current YouTrack task and RUN before mutation.
- Reuse the existing task, branch, and PR when the scope signature matches.
- Convert prompt artifacts into executable steps.
- Install durable controls when the prompt requests governance, validator, schema, fixture, receipt, or register changes.
- Record validation evidence and a receipt.
- Move the task through the board lifecycle and read back final Done before final success.
- Keep owner output compact and terminal-only.

## Forbidden Output

Final or terminal output must not contain raw sections such as `Task Class`, `Mission`, `Source Of Truth`, `Execution Order`, `Required Schema Fields`, `Validator Rules`, large YAML/frontmatter bodies, corrected prompt blocks, or copy/paste instructions.

## Terminal States

Allowed terminal states are `DONE_WITH_EVIDENCE`, `READY_BLOCKED_BY_PLATFORM_GATE`, `OWNER_ONLY_IRREVERSIBLE_GATE`, `FORBIDDEN_SCOPE_BLOCKER`, `INSTRUCTION_SOURCE_DRIFT`, `WRONG_TASK_CLASS_BLOCKER`, and `SAFETY_QUARANTINE`.

## Done Gate

A green closure requires task readback, duplicate check, implementation evidence, validation evidence, receipt path, no-secret proof, and final YouTrack Done/PASS readback. A prompt, plan, branch, receipt-only artifact, or sandbox output is not enough.
