---
artifact_id: agenthub-eval-context-health-patterns
artifact_type: governance-control
owner_role: T0 Registrar
source_task: AH-532
run_id: RUN-pattern-implementation-ah531-ah532-20260525
created_at: 2026-05-25
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# AgentHub Evaluation and Context-Health Pattern Control

## Purpose

This control adapts the AH-527 Microsoft pattern findings into AgentHub-local
prompt evaluation and Registrar hygiene. It does not install, clone, vendor,
execute, import, or run `microsoft/AI-Engineering-Coach`.

## Pattern Decision

AgentHub may adapt observer/coach concepts only as privacy-preserving control
checks over redacted receipts, registers, task fields, and bounded final
reports. AgentHub must not parse raw session logs, raw transcripts, IDE storage,
screenshots, private prompts, or secret-bearing terminal output unless a
separate security/privacy task authorizes that exact surface.

## Evaluation Rule Contract

AgentHub evaluation rules must define:

| Field | Requirement |
|---|---|
| `rule_id` | Stable id. |
| `source_task` | YouTrack task that authorizes the rule. |
| `owner_role` | Registrar, Verifier, T1, or scoped worker. |
| `input_surface` | Redacted receipt, register row, task field, PR metadata, or final report. |
| `forbidden_input` | Raw transcript, secret, private prompt, runtime logs, or unrelated project data. |
| `severity` | `info`, `warning`, `blocker`, or `terminal_blocker`. |
| `trigger` | Machine-checkable condition or checklist item. |
| `false_positive_policy` | How to downgrade or waive with evidence. |
| `evidence_output` | Where findings are recorded. |
| `done_effect` | Whether it can block Done. Eval output alone can never prove Done. |

## Required Control Checks

Registrar and Verifier workflows should check these classes before final Done:

| Class | Blocker when failed | Description |
|---|---|---|
| Task-first routing | `TASK_ANCHOR_MISSING` | Work lacks YouTrack task or accepted child task. |
| Role boundary | `ROLE_BOUNDARY_DRIFT` | T0 or wrong worker mutates outside allowed scope. |
| Direct Git/GitHub bypass | `GIT_ROUTE_BYPASS` | Git/GitHub mutation lacks task-bound AgentHub route. |
| Context pack loaded | `CONTEXT_BASELINE_MISSING` | Current context pack/registers were not read before reports. |
| Stale report replay | `STALE_REPORT_REPLAY_RISK` | Audit-only reports are used as active instructions. |
| Done evidence | `DONE_EVIDENCE_MISSING` | Implementation, validation, receipt, or task readback is missing. |
| Token/tool loop | `REPEATED_GATE_LOOP` | Same gate or retry loop repeats without new evidence. |
| Skill selection | `SKILL_SELECTION_MISSING` | Required skill/use evidence is absent for the task class. |
| Secret/redaction | `SECRET_OR_TRANSCRIPT_RISK` | Secret, env dump, raw transcript, or private link risk exists. |
| PR queue hygiene | `PR_QUEUE_UNREGISTERED` | Open PR is not represented in `PR_QUEUE_REGISTER.md`. |

## Context-Health Snapshot

A control-spine receipt should include a compact context-health snapshot when
the task changes governance, prompts, skills, register state, or PR queue state:

- current context pack read: pass/fail/not_applicable;
- `ARTIFACT_REGISTER.md` read: pass/fail;
- `PR_QUEUE_REGISTER.md` read: pass/fail;
- reports default-loaded: false unless task-specific;
- consumed prompts replayed: false;
- skill selection recorded: pass/fail;
- token/loop guard state: pass/fail;
- no raw secret/transcript input stored: pass/fail.

## Token-Cost and Loop Hygiene

Token-cost checks are governance controls, not billing claims. They should
detect:

- repeated prompt replay instead of current context pack;
- repeated same-gate retries;
- broad report loading when register says audit-only;
- duplicate PR or task creation;
- long chat output when the task requires compact final output.

When the same gate fails twice, the next step must be architecture repair,
alternate validation, or typed terminal blocker. Cosmetic retries are invalid.

## Skill-Discovery Gate

Repeated task patterns may become candidate skills only after:

1. user/task data is redacted;
2. no raw transcript or secret is copied;
3. the candidate is scoped to task classes and negative matches;
4. lifecycle metadata is set;
5. Registrar review approves default-load and replay safety.

## Rejection Rules

Reject any adaptation that:

- installs VS Code extensions, VSIX packages, dashboards, or local log parsers;
- treats local log analysis as Done proof;
- analyzes raw session stores without a privacy/security task;
- creates a score that overrides task readback, validation, or receipt;
- turns evaluator output into automatic runtime mutation.

## Acceptance

AH-532 is satisfied when this control, register/index coverage, validation
evidence, PR readback, and YouTrack Done gate all pass.
