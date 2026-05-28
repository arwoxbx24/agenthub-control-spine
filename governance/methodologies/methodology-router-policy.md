---
artifact_id: methodology-router-policy
artifact_type: active_policy
owner_role: T1 Architect / Methodology Router
source_task: AH-595
run_id: RUN-P0-PROJECT-METHODOLOGY-MIRROR-20260528
created_at: 2026-05-28
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
supersedes: governance/agenthub-methodology-router.md
---

# Methodology Router Policy

This policy is the canonical project-source mirror router. It reuses the
enforcement rules installed by `governance/agenthub-methodology-router.md` and
binds them to the mirrored catalog under `governance/methodologies/`.

## Required Selection Receipt

Before serious worker mutation, the selected route must contain:

- `TASK_CLASS`
- `ROLE`
- `ACTIVE_METHODS`
- `FORBIDDEN_METHODS`
- `ACTIVE_SKILLS`
- `FORBIDDEN_SKILLS`
- `SCOPE_SIGNATURE`
- `NEGATIVE_MATCHES`
- `RUN_ID`
- `EVIDENCE_TARGETS`

Missing selection blocks mutation with `METHOD_ROUTER_SELECTION_MISSING`.

## Profiles

| Profile | Use | Required methods | Forbidden default |
|---|---|---|---|
| `MICRO` | short answer, file link, simple fact | lightweight capture/final close | C4, DDD, Event Storming, Debugging Ladder, full eval expansion |
| `STANDARD` | prompt generation, corrective prompt, non-runtime architecture note | ReAct, Plan-and-Execute, ADR-lite when architectural, review checklist when code-related | incident-only methods |
| `INCIDENT` | broken AgentHub, runtime incident, task loop, fake Done risk | ReAct, Debugging Ladder, Observability, 5 Whys/RCA, rollback planning, SRE closure | Chaos outside safe simulation |
| `FULL` | durable AgentHub architecture, project setup, governance, role boundary, lifecycle rules | three options, ADR, C4 overview, relevant DDD/context boundaries, GitOps, DevSecOps, SRE, prompt evals | all-method overload |

## Model Route Integration

Code, shell, bash, YAML, Docker Compose, config, frontend, backend, tests, and
IaC work must prefer a Codex-capable development route when available. Fallback
is allowed only inside the same RUN with primary-unavailable evidence and no
duplicate RUN.

## Evidence Rule

Report-only, PR-only, sandbox-only, or GitHub-only Done is invalid. Done
requires implementation evidence, validation evidence, receipt, register/index
coverage, PR queue state, and YouTrack readback.

