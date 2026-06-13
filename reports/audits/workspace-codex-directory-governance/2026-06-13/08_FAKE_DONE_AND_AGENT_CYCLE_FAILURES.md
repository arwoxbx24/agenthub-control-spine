---
artifact_id: workspace-codex-directory-governance-fake-done-failures-20260613
artifact_type: audit_report
source_task: AH-786
run_id: global-workspace-codex-dir-audit-20260613
lifecycle: audit_only
default_load: false
safe_to_replay: false
---

# Fake Done And Agent Cycle Failures

## Observed Failure Patterns

1. Evidence exists by meaning but fails parser because marker format differs.
2. Agent repeats status transition attempts instead of reading gate source.
3. Shell/read route blocks are treated as owner blocker instead of PackFix/tool-route issue.
4. User-facing progress messages interrupt urgent contour.
5. Runtime outputs named `final` are mistaken for terminal proof.
6. Reports are confused with installed controls.
7. Low-level checks are treated as product/user outcome proof.

## AH-785 Specific Lesson

Done gate required exact description markers:

```text
Implementation evidence: ...
Validation evidence: ...
Receipt: ...
Blocker: none
```

Lowercase semantic equivalents did not pass. Parser-first workflow required.

## Required Machine Gates

- no Done without Done Evidence Tuple;
- no owner-closed without exact owner command;
- no routine blocker final;
- no repeated blind retry after first gate failure;
- after first failed gate, search exact error string, read parser/schema, build canonical payload, dry-run if available, apply once, read back.

## PackFix Standard

Routine missing proof, missing route, missing parser marker, missing register row, stale report, or unclear directory purpose becomes same-RUN PackFix or audit finding. Owner stop only for typed irreversible owner gates.
