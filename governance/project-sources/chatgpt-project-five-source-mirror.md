---
artifact_id: chatgpt-project-five-source-mirror
artifact_type: active_source_mirror
owner_role: T1 Architect / Registrar
source_task: AH-595
run_id: RUN-P0-PROJECT-METHODOLOGY-MIRROR-20260528
created_at: 2026-05-28
lifecycle_status: active_source
default_load: false
safe_to_replay: false
---

# ChatGPT Project Five-Source Mirror

This mirror records the stable ChatGPT Project source model for AgentHub
control-spine. It does not replace the ChatGPT Project Instructions and does
not modify the five stable Project Sources.

## Stable Project Sources

| # | Project source | Mirror status |
|---|---|---|
| 1 | `AGENTHUB-PROJECT-MASTER-ARTIFACT.txt` | documented, unchanged |
| 2 | `AGENTHUB-ARCHITECT-BRAIN-ADAPTED-SOURCE-ARTIFACT.txt` | documented, unchanged |
| 3 | `AGENTHUB-GITHUB-CONTROL-SPINE-BRIDGE-ARTIFACT.txt` | documented, unchanged |
| 4 | `AGENTHUB-CODEX-SKILL-GUARDRAIL-SOURCE-ARTIFACT.txt` | documented, unchanged |
| 5 | `AGENTHUB-PROMPT-ARCHITECTURE-EVALUATION-SOURCE-ARTIFACT.txt` | documented, unchanged |

## Methodology HTML Handling

The owner-provided methodology HTML is task data and catalog source material,
not a sixth always-loaded ChatGPT Project Source.

- protected source link: `https://b244.ru/fx`
- read route: AgentHub `agent_link_read`
- read receipt sha256: `f93f5d383cc8a5865bfceccda436f3104e18061b2b5eca014cff4906cfe35eb9`
- local source file name reported by intake: `sharex-d4V1GH.html`
- mirrored catalog path: `governance/methodologies/ai-agent-methodology-catalog.md`

Agents must reference the catalog path and receipt hash instead of pasting raw
HTML into prompts or loading all methodology text into every session.

## Register Rule

The five-source mirror is an active source mirror with `default_load=false`.
It is safe for classification and audit, but it is not executable instruction
unless the current AgentHub RUN selects it through the methodology router.

