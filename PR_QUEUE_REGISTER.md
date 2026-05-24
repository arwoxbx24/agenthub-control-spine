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
| `#33` | `AH-529` | `RUN-control-spine-agent-output-link-intake-repair-20260524` | `agenthub/agent-output-link-intake-control-20260524` | T0 Registrar | `MERGED` | Merged on 2026-05-24 after required `gitleaks` passed. Corrective control package for report placement, short-link stale-index handling, compact final output, no-repeat gates, PR/report lifecycle, and evidence-backed Done. | PR `#33`; merge commit `c0073059e346f49582db0582a32df2c9dcd8ffed`; `governance/agent-output-and-link-intake-control.md`; `runbooks/agent-shortlink-intake-and-report-placement.md`; `schemas/agent-output-quality-receipt.schema.json`; `reports/receipts/AH-529-agent-output-link-intake-repair-receipt.md` | none |
| `#29` | `AH-526` | `UNKNOWN_NOT_EXPOSED` | `agenthub/ah-526-session-failure-report` | T0 Registrar | `MERGED` | Merged on 2026-05-24 after required `gitleaks` passed. Incident report moved from GitHub Issue surface into repository artifact file, indexed, registered as audit-only, and paired with receipt. | PR `#29`; merge commit `466e236ed471ba822e631c212de881b18f808d4e`; `reports/incidents/AH-526-session-failure-report.md`; `reports/receipts/AH-526-session-failure-report-receipt.md`; Issue `#28` readback | none |
| `#30` | `AH-528` | `RUN-control-spine-cyber-safe-prompt-wording-20260524` | `agenthub/cyber-safe-prompt-wording-20260524` | T0 Registrar | `MERGED` | Merged on 2026-05-24 after required `gitleaks` passed. Cyber-safe prompt wording policy added as governance-only control. No runtime, secret, or infrastructure surface touched. | PR `#30`; merge commit `746ef1efa05eda1ac3ebea4ddd4b9abb9b8f5bfe`; `governance/cyber-safe-prompt-wording-policy.md`; `reports/receipts/cyber-safe-prompt-wording-receipt-20260524.md` | none |
| `#26` | `AH-527` | `RUN-agenthub-external-repo-pattern-audit-20260524` | `agenthub/external-repo-pattern-audit-20260524` | T1 Architecture Broker | `MERGED` | Merged on 2026-05-24 after required `gitleaks` passed. Research/adaptation package evaluates Anthropic and Microsoft public repos as pattern sources only; no runtime dependency, no install, no code import. | PR `#26`; merge commit `dbbab30caa33021e2662416d7c29f0205dcde3be`; `reports/research/external-agent-framework-pattern-audit-20260524.md`; `reports/receipts/external-agent-framework-pattern-audit-receipt-20260524.md` | none |
| `#24` | `AH-522` / `AH-523` / `AH-524` | `RUN-teamlead-control-spine-system-inventory-20260524`; `RUN-teamlead-control-spine-registrar-20260524` | `agenthub/teamlead-control-spine-system-inventory-20260524` | T0 Registrar | `MERGED` | Merged on 2026-05-24 after AH-524 installed the autonomous control-spine artifact lane: required review removed for this repository only, required `gitleaks` status check enabled, force push/delete still disabled. | PR `#24`; merge commit `6f4ffc6e068b148ab8b7fe9531a9c5e9669de011`; `reports/receipts/control-spine-pr-queue-cleanup-receipt-20260524.md`; `AH-524` | none |
| `#23` | `AH-518` / `AH-521` | `RUN-close-ah521-deferred-done-20260524` | `agenthub/close-npm-gaps-no-dup-20260524` | Scoped worker/T0 closure | `stale_closed` | Closed on 2026-05-24 as an unmerged artifact tail. AH-521/AH-518 state is recorded in YouTrack; PR evidence remains historical and is not default context. | PR `#23`; YouTrack `AH-521` and `AH-518` readback | none after close |
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
| none | PR queue clean after PR `#33` merge; AH-529 controls are active and non-default unless task-specific | none |
