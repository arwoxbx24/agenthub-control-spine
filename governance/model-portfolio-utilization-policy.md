---
artifact_id: model-portfolio-utilization-policy
artifact_type: active_policy
owner_role: T1 Architect / Model Route Controller
source_task: AH-590
run_id: RUN-P0-GLOBAL-MODEL-PORTFOLIO-ROUTE-CLOSURE-20260529
created_at: 2026-05-29
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Model Portfolio Utilization Policy

## Decision

AgentHub model routing is portfolio-based. A route is healthy only when eligible
tasks are assigned to the correct route class, wrong routes are blocked, and the
route has canary proof, active eligible task proof, an idle classification, or a
typed unavailable blocker.

## Route Classes

| Route class | Purpose | Required evidence |
|---|---|---|
| `CONTROL_T0` | intake, classification, routing, final owner output | control route receipt; no code authorship |
| `ARCHITECT_T1` | incident architecture, ADR, bounded source design | bounded source packet and architecture receipt |
| `CODEX_PRIMARY_T2` | code/config/YAML/shell/frontend/backend/test/IaC | Spark/Codex proof; primary model denied |
| `CODEX_FALLBACK_T2` | same-RUN Codex fallback | same-RUN Spark/Codex unavailability proof |
| `REGISTRAR` | index/register/PR queue/task readback | deterministic or lower-cost registrar receipt |
| `VERIFIER_QA` | read-only evidence and validation review | read-only verifier receipt |
| `SECURITY_REDACTION` | secret/raw-output checks | deterministic scanner proof first |
| `BROWSER_PRODUCT_QA` | browser/user outcome checks | browser/user outcome evidence |
| `DEVOPS_RUNTIME` | scoped live runtime work | exact live task, rollback, validation |

## Global Rules

- GPT-5.5/main/base/primary models may classify and reason, but must not author
  code/config/YAML/shell implementation.
- Code/config/YAML/shell work prefers `gpt-5.3-codex-spark` when available,
  then `gpt-5.3-codex`, then same-RUN approved Codex fallback.
- Owner-visible Spark subscription meter residual is tracked separately as
  `CODEX_SPARK_PLATFORM_METER_UNAVAILABLE`; it does not permit GPT-5.5
  fallback for code work when local Codex JSON usage proof exists.
- Stale prompts/reports cannot override `ARTIFACT_REGISTER.md` lifecycle.
- Open PR queue entries must have owner role, queue class, next action,
  evidence link, and blocker.
- Same-gate third failure becomes `SELF_HEALING_ESCALATION`.

