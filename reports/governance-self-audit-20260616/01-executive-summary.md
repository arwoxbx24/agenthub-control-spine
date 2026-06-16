# Executive Summary

## Finding

Recent AH-793 handling had real governance failures. User count was hyperbole; fact-check supports several high-severity classes:

- Wrong escalation: missing browser/admin route became user delegation instead of same-run route recovery or typed no-touch closure.
- Scope confusion: stale AH-793 prompt kept pulling toward a client project after newer owner no-touch command.
- Layer collision: Ponytail, Caveman, AgentHub safety, Plan/Default mode, and project no-touch rules lacked one conflict resolver.
- Evidence drift: tracker state showed Done/PASS while later comments and fields recorded missing browser proof and blockers.
- Hook friction: runtime hook blocked direct shell/patch without task/readback context; safety was correct, recovery path was too opaque.
- Language drift: technical policy is mixed-language; English-only technical spine would reduce token cost and ambiguity.

## Severity

- Critical: scope confusion around client project no-touch and browser/admin proof.
- High: Done plus blocker contradiction on same tracker issue.
- High: repeated layer overlap causes loops and false blockers.
- Medium: verbose policy corpus raises token cost and failure probability.
- Medium: hook denial reasons are terse and do not auto-transform into next valid route.

## Immediate Remediation

1. Add one conflict-resolution rule: newest explicit owner scope command wins over stale prompts, unless it asks for forbidden destructive work.
2. Split “cannot execute” into two machine states: `BLOCKED_BY_MISSING_AUTH_ROUTE` and `SKIPPED_BY_OWNER_NO_TOUCH_DIRECTIVE`; never mix either with Done.
3. Consolidate repeated AgentHub-first, forbidden-zone, model, protected-link, language, and Done rules into one English technical policy spine.
4. Keep Russian only for user-facing response requirements, localized task titles/descriptions, quoted user data, and UI labels.
5. Add validator that fails when an issue has `Stage=Done` plus active blocker field not equal `none` or a historical non-actionable value.

## Target Outcome

Reduce always-loaded instruction volume by 15-35% without reducing safety. Keep hard gates for DB, Docker, Nginx, proxy, firewall, secrets, protected links, client-project writes, and evidence-before-Done.
