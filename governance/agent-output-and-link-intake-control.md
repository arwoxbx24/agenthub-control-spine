---
artifact_id: governance-agent-output-and-link-intake-control
artifact_type: governance-policy
owner_role: T0 Registrar
source_task: AH-529
run_id: RUN-control-spine-agent-output-link-intake-repair-20260524
created_at: 2026-05-24
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Agent Output and Link Intake Control

This control prevents repeated agent confusion around report placement,
short-link intake, final-output noise, stale reports, PR tails, and shallow
Done claims. It is a repository governance control only and does not authorize
runtime, Docker, proxy, database, firewall, DNS, SSL, object storage, secret, or
client-product mutation.

## Decision

Decision: `CREATE_ONE_CORRECTIVE_PR`.

Fact audit showed that GitHub Issue `#28` was already closed and sanitized,
PR `#29` was merged, and the AH-526 report is now an `audit_only` repository
artifact. However, the short-link stale-index rule and compact final-output
rule existed only as incident findings, not as an active control. This policy
promotes those durable decisions into governance.

## Mandatory Rules

1. Reports must be repository files, not GitHub Issues.
2. GitHub Issues are never the task system. YouTrack remains the task system.
3. Reports, receipts, and prompts default to `default_load=false` unless
   `ARTIFACT_REGISTER.md` explicitly marks them as current.
4. A report without `INDEX.md` and `ARTIFACT_REGISTER.md` coverage is
   incomplete.
5. If local protected-link storage says `NOT_FOUND`, timeout, or stale object
   but a live short-link route succeeds, classify the incident as
   `STALE_LOCAL_LINK_INDEX`, not a broken user link.
6. Short-link intake must use a compact route: one intake/resolve step and one
   read/download step. Repeated request loops are forbidden.
7. User-facing caveman final output must use exactly:

```text
Fact: <one line>
Action: <one line>
Left: <none or exact blocker>
```

8. Intermediate terminal chatter is forbidden unless it gives a user-useful
   result or an exact typed blocker.
9. T0 cannot mutate runtime, client product, Docker, proxy, database, firewall,
   DNS, SSL, object storage, or secrets.
10. The same gate error repeated twice must become architecture repair or a
    typed blocker, not a third cosmetic retry.
11. Wrong task class must stop before work starts.
12. Done requires task readback, implementation evidence, validation evidence,
    register coverage, receipt, no active blocker, and no fake proof from PR
    creation alone.

## Incident Class Ledger

| Incident class | Current classification | Control action |
|---|---|---|
| Report written into GitHub Issue instead of repository file | `solved_verified` | Issue `#28` closed/sanitized; PR `#29` merged report file. |
| PR with one report and no index/register/receipt | `solved_verified` | AH-526 report has `INDEX.md`, `ARTIFACT_REGISTER.md`, receipt, and PR queue coverage. |
| Report generation confused with task mutation | `active_control_required` | This control separates evidence reports from task execution/Done. |
| Long chat status noise | `active_control_required` | Compact final-output rule installed here. |
| Task closure without evidence or blocked payloads | `active_control_required` | Done evidence and no-repeat gate installed here. |
| Short-link local index mismatch | `active_control_required` | `STALE_LOCAL_LINK_INDEX` and compact resolver route installed here. |
| Too many link intake/read/download requests | `active_control_required` | Resolver route is capped to one intake plus one read/download. |
| Old reports used as active instructions | `solved_verified` | Artifact register marks reports as non-default evidence. |
| Broad cycles and PR tails | `solved_verified` | PR queue register is current and open queue was empty at audit start. |
| Misleading Done or plan-only output | `active_control_required` | Done evidence rule and final format installed here. |

## Typed Blockers

- `STALE_LOCAL_LINK_INDEX`
- `LINK_INTAKE_ROUTE_UNAVAILABLE`
- `REPORT_PLACEMENT_INVALID`
- `INDEX_REGISTER_COVERAGE_MISSING`
- `PR_QUEUE_COVERAGE_MISSING`
- `FINAL_OUTPUT_NOISE`
- `TASK_CLASS_MISMATCH`
- `DONE_EVIDENCE_MISSING`
- `REPEATED_GATE_LOOP`
- `FORBIDDEN_RUNTIME_SURFACE`
- `SECRET_OR_RAW_TRANSCRIPT_RISK`

## Done Guard

Do not call a task Done when any of these are true:

- report or receipt is stored only in GitHub Issues;
- required report is missing index/register coverage;
- short-link was declared broken before local and live routes were checked;
- final output contains internal logs or process chatter instead of the compact
  result;
- old report text is being used as default instruction;
- PR creation or a green check is the only proof;
- task-service writeback is blocked or child tasks remain open.
