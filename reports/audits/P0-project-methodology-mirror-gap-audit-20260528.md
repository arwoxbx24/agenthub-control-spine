---
artifact_id: p0-project-methodology-mirror-gap-audit-20260528
artifact_type: audit_report
owner_role: T1 Architect / Verifier
source_task: AH-595
run_id: RUN-P0-PROJECT-METHODOLOGY-MIRROR-20260528
created_at: 2026-05-28
lifecycle_status: audit_only
default_load: false
safe_to_replay: false
---

# P0 Project Methodology Mirror Gap Audit

## Executive Summary

PR #88/#89 installed a methodology enforcement layer and black-box route
registry. The remaining project-source gap was the lack of an explicit
ChatGPT five-source mirror, governed methodology catalog path, exact
project-source mirror schema, exact worker template, and AGENTS.md reference
that prevents the methodology HTML from becoming a sixth always-loaded source.

## Evidence Sources

- protected methodology source: `https://b244.ru/fx`
- protected-link read route: AgentHub `agent_link_read`
- protected-link read sha256: `f93f5d383cc8a5865bfceccda436f3104e18061b2b5eca014cff4906cfe35eb9`
- repository baseline: `AGENTS.md`, `INDEX.md`, `ARTIFACT_REGISTER.md`,
  `PR_QUEUE_REGISTER.md`, `context/agenthub-current-context-pack.md`,
  `governance/agenthub-methodology-router.md`,
  `validators/agenthub_methodology_router_validator.rb`,
  `evals/agenthub-methodology-router/fixtures.json`

## Three Options

| Option | Decision | Reason |
|---|---|---|
| A. Document only | rejected | Would leave enforcement dependent on prose and existing context. |
| B. Catalog + schema + validator + evals + AGENTS references | accepted | Closes source-mirror and router-selection gaps without live-runtime mutation. |
| C. Full runtime hook integration | deferred | Requires separate live runtime hook proof; not claimed from repository files. |

## Gap Table

| Gap | Baseline | Fix |
|---|---|---|
| Five Project Sources not mirrored as an explicit control-spine artifact | implicit in prompt/user contract | `governance/project-sources/chatgpt-project-five-source-mirror.md` |
| HTML methodology catalog not stored as governed catalog data | PR #88 policy catalog existed, but not source-mirror linked | `governance/methodologies/ai-agent-methodology-catalog.md` |
| Exact project-source mirror schema missing | absent | `schemas/project-source-mirror.schema.json` |
| Exact router selection schema with skills/negative matches/evidence targets missing | prior schema lacked project-source mirror shape | `schemas/methodology-router.schema.json` |
| Exact validator path requested by contract missing | prior validator existed at root path | `validators/methodology-router/validate-methodology-router.rb` |
| Worker template to avoid all-method prompt bloat missing | absent | `prompts/templates/methodology-router-worker-template.md` |
| AGENTS.md did not reference catalog/source mirror | absent | AGENTS.md patched |

## Black-Box Closure Mapping

| Vector | Installed control |
|---|---|
| T0 command route bypass | existing black-box/action validators plus new N1 fixture |
| Old sessions continuing without new rules | AGENTS.md reference and report replay denial |
| Command adapter direct shell | black-box route registry and T0 deny |
| Report without registers | new N7 and repo-first gate |
| Task without duplicate check | AgentHub task-service duplicate search receipt |
| GitHub-only Done | new N6 and repo-first gate |
| Sandbox proof as product Done | existing PR #88 fixture and policy |
| Model fallback without evidence | existing PR #84/#88 model route gates |
| Methodology all-bloat | new N2 and existing PR #88 fixture |
| Secret guessing | source mirror uses protected link read and no raw HTML/secret dump |
| Consumed prompt replay | new N8 and artifact lifecycle rule |
| Same gate repeated | new N9 and self-healing loop policy |

## Final Audit Decision

Balanced architecture is implemented in this branch. Live runtime hook
installation is not claimed from repository-only evidence.

