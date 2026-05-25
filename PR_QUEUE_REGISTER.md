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

This register is the authoritative queue view for open and recently closed control-spine PR tails. It prevents stale PRs from acting as current instructions.

## Registrar Decision Model

| Option | Decision | Reason |
|---|---|---|
| A: every agent cleans its own artifacts | rejected | Cross-task cleanup lets workers modify or delete unrelated evidence. |
| B: one Control-Spine Registrar | accepted | TeamLead/T0 owns lifecycle, queue, archive/quarantine, and baseline; workers only propose metadata. |
| C: no cleanup | rejected | Context grows without bound and stale reports/prompts become pseudo-instructions. |

## Queue Snapshot

| PR | Task id | RUN_ID | Branch | Owner role | Queue class | Registrar action | Evidence link | Blocker |
|---|---|---|---|---|---|---|---|---|
| `#39` | `AH-534` / `AH-535` / `AH-536` / `AH-537` | `RUN-control-spine-agenthub-only-execution-discipline-20260525`; `RUN-live-502-portainer-docker-incident-20260525`; `RUN-agenthub-safe-recovery-control-20260525` | `agenthub/agenthub-only-execution-discipline-20260525` | T0 Registrar | `READY_BLOCKED_BY_AGENTHUB_LIVE_ADAPTER` | Installs AgentHub-only execution discipline; reuses the existing PR tail to quarantine direct T0 runtime route bypass and record the live 502 adapter remediation gate. | PR `#39`; `governance/agenthub-only-execution-discipline.md`; `runbooks/agenthub-only-violation-response.md`; `runbooks/agenthub-live-execution-adapter-remediation.md`; `schemas/agenthub-only-execution-receipt.schema.json`; `reports/receipts/AH-534-agenthub-only-execution-discipline-receipt.md`; `reports/receipts/AH-536-AH-537-live-execution-route-repair-receipt.md`; `governance/agenthub-safe-recovery-control.md`; `runbooks/agenthub-safe-recovery-control-loop.md`; `prompts/architecture/agenthub-safe-recovery-control-prompt.txt`; `reports/receipts/AH-534-agenthub-safe-recovery-control-receipt.md` | AgentHub merge residual `MCP_RECEIPT_REQUIRED_FOR_IMPLEMENTATION_DONE`; remediation task `AH-535`; live worker blocker `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` in `AH-537` |
| `#37` | `AH-533` | `RUN-control-spine-git-route-policy-20260525` | `agenthub/git-route-policy-20260525` | T0 Registrar | `MERGED` | Merged on 2026-05-25. Adds explicit AGENTS.md rule that Git/GitHub mutation for control-spine must be YouTrack-task-bound and AgentHub-routed with RUN_ID, branch, evidence, validation, and receipt. | PR `#37`; merge commit `329b920d89caf0465293d4747b9106b9531257ee`; `AGENTS.md`; `reports/receipts/AH-533-git-route-policy-receipt.md` | none |
| `#35` | `AH-530` / `AH-531` / `AH-532` | `RUN-external-pattern-adaptation-closure-20260524` | `agenthub/external-pattern-adaptation-closure-20260524` | T0 Registrar | `MERGED` | Merged on 2026-05-24 after required `gitleaks` passed. | PR `#35`; merge commit `e4163e5e5854763902caf6fff78c4c6c7017c751`; `reports/receipts/external-repo-pattern-adaptation-closed-loop-receipt.md` | none |
| `#33` | `AH-529` | `RUN-control-spine-agent-output-link-intake-repair-20260524` | `agenthub/agent-output-link-intake-control-20260524` | T0 Registrar | `MERGED` | Merged on 2026-05-24 after required `gitleaks` passed. | PR `#33`; merge commit `c0073059e346f49582db0582a32df2c9dcd8ffed`; `reports/receipts/AH-529-agent-output-link-intake-repair-receipt.md` | none |
| `#29` | `AH-526` | `UNKNOWN_NOT_EXPOSED` | `agenthub/ah-526-session-failure-report` | T0 Registrar | `MERGED` | Merged on 2026-05-24 after required `gitleaks` passed. | PR `#29`; merge commit `466e236ed471ba822e631c212de881b18f808d4e`; `reports/receipts/AH-526-session-failure-report-receipt.md` | none |
| `#30` | `AH-528` | `RUN-control-spine-cyber-safe-prompt-wording-20260524` | `agenthub/cyber-safe-prompt-wording-20260524` | T0 Registrar | `MERGED` | Merged on 2026-05-24 after required `gitleaks` passed. | PR `#30`; merge commit `746ef1efa05eda1ac3ebea4ddd4b9abb9b8f5bfe`; `governance/cyber-safe-prompt-wording-policy.md` | none |
| `#26` | `AH-527` | `RUN-agenthub-external-repo-pattern-audit-20260524` | `agenthub/external-repo-pattern-audit-20260524` | T1 Architecture Broker | `MERGED` | Merged on 2026-05-24 after required `gitleaks` passed. | PR `#26`; merge commit `dbbab30caa33021e2662416d7c29f0205dcde3be` | none |
| `#24` | `AH-522` / `AH-523` / `AH-524` | `RUN-teamlead-control-spine-system-inventory-20260524`; `RUN-teamlead-control-spine-registrar-20260524` | `agenthub/teamlead-control-spine-system-inventory-20260524` | T0 Registrar | `MERGED` | Merged on 2026-05-24 after AH-524 installed the autonomous control-spine artifact lane. | PR `#24`; merge commit `6f4ffc6e068b148ab8b7fe9531a9c5e9669de011`; `reports/receipts/control-spine-pr-queue-cleanup-receipt-20260524.md` | none |
| `#23` | `AH-518` / `AH-521` | `RUN-close-ah521-deferred-done-20260524` | `agenthub/close-npm-gaps-no-dup-20260524` | Scoped worker/T0 closure | `stale_closed` | Closed on 2026-05-24 as an unmerged artifact tail. | PR `#23`; YouTrack `AH-521` and `AH-518` readback | none after close |
| `#20` | `AH-513` / `AH-518` | `RUN-teamlead-ah513-ah518-control-20260523` | `agenthub/teamlead-ah513-ah518-control-20260523` | T0 control receipt | `SUPERSEDED_CLOSE` | Closed on 2026-05-24 as stale. | `AH-513`, `AH-518`, PR `#22` | none after close |
| `#18` | `AH-468` | `RUN-teamlead-mtproxy-parallel-control-20260523` | `agenthub/teamlead-mtproxy-parallel-control-20260523` | T0 control receipt | `SUPERSEDED_CLOSE` | Closed on 2026-05-24 as stale. | PR `#19` | none after close |
| `#17` | lifecycle repair | `UNKNOWN_NOT_EXPOSED` | `agenthub/control-spine-lifecycle-20260523` | Repo artifact worker | `SUPERSEDED_CLOSE` | Closed on 2026-05-24 after useful lifecycle decisions were extracted into current registrar PR `#24`. | `governance/control-spine-registrar-policy.md`; `context/agenthub-current-context-pack.md`; `ARTIFACT_REGISTER.md` | none after close |
| `#16` | global control repair | `RUN-agenthub-global-control-spine-audit-20260523` | `agenthub/RUN-agenthub-global-control-spine-audit-20260523` | Architecture/repo artifact worker | `SUPERSEDED_CLOSE` | Closed on 2026-05-24 as stale/conflicting. | PR `#16` file list/readback; PR `#24` registrar package | none after close |

## Closed PR Rule

Closed stale PRs remain auditable through GitHub history. Closing does not delete evidence. Useful decisions must exist in main or in the current registrar PR before closure.

## Open PRs After Registrar Cleanup

| PR | Decision | Blocker |
|---|---|---|
| `#39` | Open AH-534/AH-536/AH-537 governance-only PR for AgentHub-only execution discipline and live execution adapter remediation. | AgentHub merge residual `MCP_RECEIPT_REQUIRED_FOR_IMPLEMENTATION_DONE`; remediation task `AH-535`; live adapter blocker `CONTRACT_ONLY_RUNTIME_LIVE_DISPATCH_BLOCKED` in `AH-537` |
