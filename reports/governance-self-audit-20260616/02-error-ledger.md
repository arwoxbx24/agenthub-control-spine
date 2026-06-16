# Error Ledger

## E1: User Delegation Instead Of Route Resolution

Evidence: AH-793 continuation ended with `TEST_AUTH_REQUIRED_OWNER_ONLY`. This was technically honest but operationally weak: agent should first exhaust safe internal browser/control-plane routes, then write a typed continuation artifact through AgentHub.

Impact: user saw “go do auth” pattern, which conflicts with autonomous-continuation rules.

Fix: missing credential/session becomes internal route task first; ask user only if no approved secret/browser lane exists and the route proof says so.

## E2: Stale Prompt Over Current Owner Scope

Evidence: AH-793 prompt demanded execution against a specific client/test URL; user later said not to touch that project. Agent initially continued reading AH-793 context before fully freezing client scope.

Impact: scope leak risk.

Fix: conflict resolver: latest explicit no-touch command quarantines stale task prompts for that project immediately.

## E3: Done + Blocker Contradiction

Evidence: AH-793 readback showed `Stage=Done` and `AH Done Gate=PASS`, while comments recorded missing browser upload/cleanup proof and later blocker/no-touch state.

Impact: board truth becomes unreliable; agents can treat a task as both closed and blocked.

Fix: validator: Done issue cannot carry active blocker. If new blocker appears, move to Review/Test or record as skipped/no-touch without claiming implementation Done.

## E4: Hook Denial Without Auto-Remediation

Evidence: shell/report writes hit `PRE_DISPATCH_TASK_GATE_MISSING_ISSUE_ID`, `YOUTRACK_READBACK_PERMISSION_MISSING`, and `T0_DIRECT_RUNTIME_MUTATION_DEFECT`. Denials were safety-correct, but next valid route was not automatically obvious.

Impact: loops, delay, noisy chat.

Fix: hook receipt must include `next_valid_route`: create/readback task, MCP dispatch, governance exception, or typed blocker.

## E5: Overlapping AgentHub Rules

Evidence: same concepts appear across root AGENTS, `.codex/AGENTS`, workspace AGENTS, technical repo AGENTS, and runtime contract: MCP-first, no direct T0, forbidden zones, protected links, model constraints, Done evidence.

Impact: larger context, higher contradiction risk, harder debugging.

Fix: move canonical technical rules into one English spine; local AGENTS only reference and narrow.

## E6: Language Policy Ambiguity

Evidence: current policy says Russian user-facing, while technical instructions and incident text can still appear in Russian.

Impact: token cost and model interpretation drift.

Fix: enforce English for prompts/contracts/validators/dispatch briefs/runtime policy. Allow Russian only for user-facing text, quoted user data, task titles/descriptions, and localized UI labels.

## E7: Efficiency Layer Confusion

Evidence: Ponytail controls build style; Caveman controls prose. Earlier discussion correctly warned not to duplicate Ponytail layer and not to use `caveman:compress` on live chat/code, but failure mode remains possible if prompts conflate style with safety.

Impact: accidental hook disable, duplicate efficiency layer, compressed machine receipts.

Fix: one efficiency contract: Ponytail = implementation minimizer; Caveman = user prose only; no compression for code/receipts/safety warnings.
