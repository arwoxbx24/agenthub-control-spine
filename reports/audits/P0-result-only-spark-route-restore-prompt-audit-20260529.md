---
artifact_id: P0-result-only-spark-route-restore-prompt-audit-20260529
artifact_type: audit_report
owner_role: T0 Control / T1 Architect / Verifier
source_task: AH-590/AH-601
run_id: RUN-P0-RESULT-ONLY-SPARK-ROUTE-PROMPT-AUDIT-20260529
created_at: 2026-05-29
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
secret_redaction_gate: PASS
---

# P0 Result-Only Spark Route Restore Prompt Audit

## Scope

Read-only audit of the owner prompt:

- restore AgentHub internal Codex Spark code-authoring route;
- forbid owner manual model selection;
- keep owner-facing output result-only;
- delete obsolete folder only after exact path binding and lifecycle checks.

No implementation was authorized by this audit. The audit checks whether the
prompt describes a missing/incorrect control or would duplicate/conflict with
already installed controls.

## Microtask Binding

- run_id: `RUN-P0-RESULT-ONLY-SPARK-ROUTE-PROMPT-AUDIT-20260529`
- task_id: `AH-P0-SPARK-ROUTE-PROMPT-AUDIT-20260529`
- worker_id: `W-readonly-spark-route-prompt-audit-01`
- route: AgentHub MCP create + dispatch
- mode: read-only verification before implementation

## Current Fact Pattern

### Already Installed / Working

- Control-spine PR queue records PR `#111` as merged with Codex Spark
  code-authoring enforcement.
- `governance/model-token-routing-policy.md` requires
  `requested_model=gpt-5.3-codex-spark` and resolved/actual Spark for
  code/config/YAML/shell/frontend/backend/test/IaC authoring.
- `validators/model_token_router_validator.rb` rejects:
  - missing requested model selector;
  - non-Spark requested model when Spark is selectable;
  - resolved/actual model mismatch;
  - GPT-5.5/main/base implementation authorship;
  - lease/requeue work counted as Spark proof.
- Runtime files currently route key internal worker defaults to Spark:
  - `roles.yaml`: backend/frontend/devops/review/docs workers default to
    `gpt-5.3-codex-spark`.
  - `model-presets.yaml`: `t2_coder` defaults to `gpt-5.3-codex-spark`.
  - `routing.yaml`: R2 implementation default is
    `gpt-5.3-codex-spark`.
  - `runtime-entrypoint.yaml`: R2+ implementation default is
    `gpt-5.3-codex-spark`.
  - `templates/spawn-plan.yaml`: generated T2 coder example resolves to
    Spark with non-Spark fallback requiring same-RUN Spark unavailability proof.

### Drift / Conflict Found

- `/root/.codex/orchestration/policy.md` still contains a stale line:
  `gpt-5.3-codex` remains the default for R2+ implementation.
- The same file also contains the newer correct line:
  R2+ implementation helpers default to `gpt-5.3-codex-spark` for code/config
  authoring.
- This is a documentation/policy contradiction, not a validator failure.
- The prompt's "no owner manual `/model` request" clause is valid and improves
  closure wording because previous user-facing output incorrectly delegated
  current-session switching to the owner.

### Folder Delete Safety

- The prompt says to delete an obsolete folder only if the exact path is bound.
- No exact obsolete folder path is provided in the prompt.
- No active control-spine artifact/register evidence identifies a specific stale
  folder for deletion.
- Safe audit state: `STALE_FOLDER_PATH_NOT_BOUND`.
- Broad folder deletion would be unsafe and must not be implemented from this
  prompt alone.

## Validation Results

- `ruby validators/model_token_router_validator.rb evals/model-token-routing/fixtures.json`
  -> PASS, 28 cases.
- `ruby validators/model_portfolio_router_validator.rb evals/model-portfolio-routing/fixtures.json`
  -> PASS, 16 cases.
- `ruby /root/.codex/orchestration/scripts/validation/runtime_policy_checks.rb`
  -> PASS.
- `ruby /root/.codex/orchestration/scripts/validation/template_checks.rb`
  -> PASS.
- Targeted contradiction search found one stale policy sentence in
  `/root/.codex/orchestration/policy.md`.

## Risk Assessment

The prompt is beneficial if implemented narrowly:

- It reinforces internal Spark selection and result-only owner communication.
- It prevents future false closure by owner manual model-selection requests.
- It blocks unsafe stale-folder deletion unless exact path evidence exists.

The prompt can break the system if implemented broadly:

- broad runtime rewrite could overwrite existing working Spark routes;
- broad folder deletion could remove active evidence, runtime state, or reports;
- forcing code-task proof when the current goal is audit-only would violate the
  user's "verify before implementing" instruction.

## Recommended Next Microtasks

1. `PROMPT_SAFE_PATCH_POLICY_DRIFT`
   - Replace the stale `gpt-5.3-codex` R2+ default sentence in
     `/root/.codex/orchestration/policy.md`.
   - Validate runtime policy and template checks.

2. `OWNER_OUTPUT_RESULT_ONLY_GATE`
   - Add or verify a final-output negative fixture rejecting owner-facing
     manual `/model` instructions for Spark-route closure.
   - Keep final output to `Fact / Action / Left`.

3. `STALE_FOLDER_DELETE_EXACT_PATH_GATE`
   - Add a deterministic fixture for stale folder deletion:
     exact path required, active register reference blocks deletion, ambiguous
     path returns `STALE_FOLDER_PATH_NOT_BOUND`.
   - Do not delete any folder until a concrete path is bound.

## Audit Decision

status: `PROMPT_PARTIALLY_ALREADY_INSTALLED_WITH_ONE_STALE_POLICY_DRIFT`

implementation_allowed_now: false

reason: The user explicitly required verification first. The audit found one
safe, narrow improvement and one folder-delete blocker. Implementation should be
a separate same-RUN microtask only if authorized by the next execution step.

safe_terminal_state_for_this_audit: `STALE_FOLDER_PATH_NOT_BOUND` for folder
cleanup; Spark route itself is mostly installed with one stale policy sentence.
