# Documentation Lookup Gate

task_id: {{TASK_ID}}
run_id: {{RUN_ID}}
target_surface: {{TARGET_SURFACE}}
confidence: {{CONFIDENCE}}

## Required?

documentation_lookup_required: {{DOCUMENTATION_LOOKUP_REQUIRED}}
trigger_reasons:
{{TRIGGER_REASONS}}

## Source Result

- official_docs_found: {{OFFICIAL_DOCS_FOUND}}
- official_docs_ref: {{OFFICIAL_DOCS_REF}}
- product_version: {{PRODUCT_VERSION}}
- supported_routes_identified: {{SUPPORTED_ROUTES_IDENTIFIED}}
- docs_unavailable_reason: {{DOCS_UNAVAILABLE_REASON}}

## Decision

- route_decision: {{ROUTE_DECISION}}
- mutation_allowed_before_docs: false
- typed_blocker_if_unavailable: {{TYPED_BLOCKER_IF_UNAVAILABLE}}

Allowed blockers:
- `DOCS_UNAVAILABLE_BLOCKER`
- `API_ROUTE_UNAVAILABLE_BLOCKER`
- `FORBIDDEN_SCOPE_BLOCKER`
- `OWNER_ONLY_IRREVERSIBLE_GATE`
