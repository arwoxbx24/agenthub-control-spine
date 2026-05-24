---
artifact_id: pr-queue-register
artifact_type: pr-queue-register
owner_role: T0 Control Plane
source_task: AH-523
run_id: RUN-teamlead-control-spine-registrar-20260524
created_at: 2026-05-24
lifecycle_status: current_baseline
default_load: true
safe_to_replay: false
---

# Control-Spine PR Queue Register

This register is the authoritative queue view for open and recently closed
control-spine PR tails. It prevents stale PRs from acting as current
instructions.

## Registrar Decision Model

| Option | Decision | Reason |
|---|---|---|
| A: every agent cleans its own artifacts | rejected | Cross-task cleanup lets workers modify or delete unrelated evidence. |
| B: one Control-Spine Registrar | accepted | TeamLead/T0 owns lifecycle, queue, archive/quarantine, and baseline; workers only propose metadata. |
| C: no cleanup | rejected | Context grows without bound and stale reports/prompts become pseudo-instructions. |

## Queue Snapshot

| PR | Task id | RUN_ID | Branch | Owner role | Queue class | Registrar action | Evidence link | Blocker |
|---|---|---|---|---|---|---|---|---|
| `#24` | `AH-522` / `AH-523` | `RUN-teamlead-control-spine-system-inventory-20260524`; `RUN-teamlead-control-spine-registrar-20260524` | `agenthub/teamlead-control-spine-system-inventory-20260524` | T0 Registrar | `MERGE_READY` | Amended as the single current registrar/lifecycle PR; merge attempt blocked by base branch policy. | `ARTIFACT_REGISTER.md`; `PR_QUEUE_REGISTER.md`; `reports/receipts/control-spine-pr-queue-cleanup-receipt-20260524.md` | `REVIEW_REQUIREMENT_BLOCKS_MERGE` |
| `#23` | `AH-518` / `AH-521` | `RUN-close-ah521-deferred-done-20260524` | `agenthub/close-npm-gaps-no-dup-20260524` | Scoped worker/T0 closure | `BLOCKED_BY_REVIEW_REQUIREMENT` | Defer; task-specific artifact PR is mergeable but must keep exact review/blocker state. | `reports/devops/npm-gap-closure-no-dup-20260524.md` | `REVIEW_REQUIREMENT_BLOCKS_MERGE` |
| `#20` | `AH-513` / `AH-518` | `RUN-teamlead-ah513-ah518-control-20260523` | `agenthub/teamlead-ah513-ah518-control-20260523` | T0 control receipt | `SUPERSEDED_CLOSE` | Closed on 2026-05-24 as stale: later YouTrack readback and PR `#22` supersede its MTProxy scope-drift finding. | `AH-513`, `AH-518`, PR `#22`, commit `16267cd97be2d94f3a9dd82f6a0ef58c320e3835` | none after close |
| `#18` | `AH-468` | `RUN-teamlead-mtproxy-parallel-control-20260523` | `agenthub/teamlead-mtproxy-parallel-control-20260523` | T0 control receipt | `SUPERSEDED_CLOSE` | Closed on 2026-05-24 as stale: worker evidence was later merged by PR `#19`; this older T0 receipt still says worker report missing. | PR `#19`, merge commit `dfc0eb4e5a5035a540a069d157eead9029248967` | none after close |
| `#17` | lifecycle repair | `UNKNOWN_NOT_EXPOSED` | `agenthub/control-spine-lifecycle-20260523` | Repo artifact worker | `SUPERSEDED_CLOSE` | Closed on 2026-05-24 after useful lifecycle decisions were extracted into current registrar PR `#24`. | `governance/control-spine-registrar-policy.md`; `context/agenthub-current-context-pack.md`; `ARTIFACT_REGISTER.md` | none after close |
| `#16` | global control repair | `RUN-agenthub-global-control-spine-audit-20260523` | `agenthub/RUN-agenthub-global-control-spine-audit-20260523` | Architecture/repo artifact worker | `SUPERSEDED_CLOSE` | Closed on 2026-05-24 as stale/conflicting: current Registrar PR `#24` owns lifecycle/register/queue controls; any useful architecture content must be reintroduced through Registrar with revalidation. | PR `#16` file list/readback; PR `#24` registrar package | none after close |

## Closed PR Rule

Closed stale PRs remain auditable through GitHub history. Closing does not delete
evidence. Useful decisions must exist in main or in the current registrar PR
before closure.

## Open PRs After Registrar Cleanup

| PR | Decision | Blocker |
|---|---|---|
| `#24` | current registrar PR, merge-ready; merge attempt blocked by branch policy | `REVIEW_REQUIREMENT_BLOCKS_MERGE` |
| `#23` | task-specific artifact PR, defer to review | `REVIEW_REQUIREMENT_BLOCKS_MERGE` |
