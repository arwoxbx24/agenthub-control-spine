# API Route Sheet

task_id: {{TASK_ID}}
run_id: {{RUN_ID}}
surface_class: {{SURFACE_CLASS}}
product_name: {{PRODUCT_NAME}}
product_version: {{PRODUCT_VERSION}}

## Official Source

- official_docs_ref: {{OFFICIAL_DOCS_REF}}
- docs_status: {{DOCS_STATUS}}
- unsupported_or_unknown_notes: {{UNSUPPORTED_OR_UNKNOWN_NOTES}}

## Supported Mechanism

- primary_route: {{PRIMARY_ROUTE}}
- auth_method: {{AUTH_METHOD}}
- read_endpoints_or_commands: {{READ_ENDPOINTS_OR_COMMANDS}}
- write_endpoints_or_commands: {{WRITE_ENDPOINTS_OR_COMMANDS}}
- permissions_or_rate_limits: {{PERMISSIONS_OR_RATE_LIMITS}}
- dry_run_or_read_only_check: {{DRY_RUN_OR_READ_ONLY_CHECK}}

## Safety

- rollback_route: {{ROLLBACK_ROUTE}}
- validation_route: {{VALIDATION_ROUTE}}
- user_outcome_route: {{USER_OUTCOME_ROUTE}}
- forbidden_direct_internals: {{FORBIDDEN_DIRECT_INTERNALS}}

## Approval

- t1_architect_review: {{T1_ARCHITECT_REVIEW}}
- qa_plausibility_review: {{QA_PLAUSIBILITY_REVIEW}}
- mutation_authority: {{MUTATION_AUTHORITY}}
