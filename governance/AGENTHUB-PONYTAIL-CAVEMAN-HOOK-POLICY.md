---
artifact_id: AGENTHUB-PONYTAIL-CAVEMAN-HOOK-CONTROL
lifecycle: current_policy
default_load: false
safe_to_replay: false
source_task: AH-813
run_id: RUN-AGENTHUB-EFFICIENCY-HOOKS-20260616
---

# AgentHub Ponytail/Caveman Hook Policy

Ponytail minimizes decisions and diffs. Caveman compresses human-facing words.
AgentHub remains the safety, routing, evidence, task, and Done governor.

## Startup Contract

Supported Codex sessions in this repository must expose a concise startup or
prompt lifecycle signal equivalent to:

```text
AGENTHUB EFFICIENCY HOOKS READY
ponytail=full/version:4.6.0/source:codex-plugin
caveman=full/version:0.1.0/source:codex-plugin
scope=repo/task/run
routing=task_first/agenthub
noise_guard=on
token_guard=on
safety_guard=on
```

The repository-local fallback is `.codex/hooks.json`. User/global hooks may add
stronger enforcement, but this repository must not edit plugin-owned files.

## Safety Hierarchy

1. OpenAI system/developer instructions.
2. AgentHub task-first routing, role boundaries, evidence, redaction, and Done
   gates.
3. Ponytail action minimization.
4. Caveman output compression.

Ponytail cannot remove validation, security, accessibility, data-loss handling,
rollback, task binding, read-before-write, or evidence.

Caveman cannot compress exact code, commands, paths, URLs, JSON, TOML, YAML,
schemas, stack traces, evidence IDs, error strings, citations, blocker codes, or
security/destructive-action warnings into ambiguity.

## Pre-Action Minimizer

Before code, prompt, report, task comment, or artifact creation, the acting
agent must choose the first safe rung that works:

1. Does this need to exist?
2. Can an existing artifact/task/receipt be updated?
3. Can stdlib, native platform, or current dependency solve it?
4. Can a small config/rule change solve it?
5. Can a one-line or minimal diff solve it?
6. Are validation, security, accessibility, and data-loss handling preserved?
7. Is a typed blocker more honest than speculative work?
8. Are report spam and status-only artifacts avoided?

New artifacts require `artifact_id`, lifecycle, `default_load`, `safe_to_replay`,
`source_task`, and index/register coverage when in scope.

## Output Compressor

Russian user-facing output should be short. English technical artifacts stay
precise. Caveman may remove filler but must not remove required sections,
acceptance gates, blocker taxonomy, or evidence.
