---
artifact_id: architect-brain-universal-agent-protocol-v5
artifact_type: methodology-registry
source_task: AH-794
prompt_id: ARCHITECT-BRAIN-UNIVERSAL-AGENT-PROTOCOL-V5-20260615
lifecycle: active_control_candidate
default_load: false
safe_to_replay: false
---

# Architect Brain Universal Agent Protocol v5

## Purpose

Register the Architect Brain methodology as a governed methodology source for AgentHub task routing, analysis, planning, validation, and closure.

## Methodology Kernel

The protocol requires an evidence-first cycle:

1. Capture.
2. Classify.
3. Analyze.
4. Triage.
5. Design.
6. Plan.
7. Validate.
8. Close.

Every phase must use a ReAct loop, OODA monitoring, Reflexion after failed gates, hallucination guard before claims, mutation guard before code/data changes, and loop watchdog for repeated blockers.

## Required Think Stack

- Cynefin.
- Eisenhower.
- MoSCoW.
- RICE.
- WSJF.
- SWOT.
- Kano.
- second-order thinking to 3 levels.
- premortem.
- 5 Whys.
- fishbone.
- FMEA.
- JTBD.
- OKR.
- North Star.
- DORA.
- ADR/RFC.
- C4.
- DDD.
- Event storming.
- Strangler fig.
- BFF.
- log strategy.
- Docker/server/code/microservice/CMS triage.

## AgentHub Binding

This methodology is not a bypass authority. It cannot override system/developer policies, production locks, branch protection, secret redaction, YouTrack/AgentHub task gates, or owner-only irreversible gates.

For state-changing work, the methodology is applied through AgentHub-controlled routes and evidence receipts. For simple text-only work, use the smallest applicable subset and do not create unnecessary artifacts.

## Completion Rule

Success requires evidence-backed completion, validation evidence, receipt/readback, zero unaddressed P0/P1 residuals in scope, no fake Done, no unsupported claims, and exact next action or owner-only gate when applicable.
