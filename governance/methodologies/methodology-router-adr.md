---
artifact_id: methodology-router-adr
artifact_type: architecture_decision_record
owner_role: T1 Architect
source_task: AH-595
run_id: RUN-P0-PROJECT-METHODOLOGY-MIRROR-20260528
created_at: 2026-05-28
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# ADR: Mirror Methodology HTML As Catalog, Not Sixth Project Source

## Context

The ChatGPT Project already has five stable Project Sources. The owner provided
an HTML methodology catalog via protected link. Loading the HTML as a sixth
always-on source would increase context, encourage all-method bloat, and weaken
the adaptive router installed by PR #88/#89.

## Options

1. Conservative: document the source only, no new validator or catalog path.
2. Balanced: mirror the source into a governed catalog, schema, validator,
   evals, worker template, registers, and AGENTS.md references.
3. Progressive: integrate live runtime hooks beyond the repository controls.

## Decision

Choose Balanced. The five Project Sources remain unchanged. The HTML is mirrored
as governed catalog data in control-spine and selected through the methodology
router only when the task class requires it.

## Consequences

- Agents can cite a stable catalog path and source hash instead of pasting raw
  HTML.
- Methodology selection remains adaptive and testable.
- Runtime hook enforcement remains a separate live-runtime proof requirement and
  is not claimed from repository-only evidence.

