---
artifact_id: agenthub-no-prompt-dump-execute-contract-policy-20260611
artifact_type: governance_policy
source_task: AH-745
run_id: RUN-AGENTHUB-BLOCKER-INVERSION-SCOPED-SELF-HEALING-20260611
status: active
---

# AgentHub No Prompt Dump Execute Contract Policy

## Purpose

Prompt artifacts, repair maps, validator instructions, architecture contracts, and corrected prompt blocks are inputs to execute, not final output.

## Hardlock

A worker must not finish by printing raw prompt text, YAML/frontmatter contracts, `Task Class`, `Mission`, `Source Of Truth`, `Execution Order`, `Required Schema Fields`, `Validator Rules`, or copy/paste instructions.

## Required Recovery

If prompt dump is detected, suppress output, rebind to the active task/RUN, execute the prompt as a scoped contract, record a receipt, and return compact terminal closure only.
