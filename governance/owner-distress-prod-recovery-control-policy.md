---
artifact_id: owner-distress-prod-recovery-control-policy
artifact_type: governance-policy
owner_role: T1 Architect / T2 Governance Worker / Registrar
source_task: AH-796
run_id: RUN-owner-distress-prod-recovery-control-20260614
created_at: 2026-06-14
lifecycle_status: active_policy
default_load: false
safe_to_replay: false
---

# Owner Distress Production Recovery Control Policy

## Purpose

Owner panic, client-impact language, and equivalent production-down complaints are P0 incident signals. Agents must not answer with apology loops, vague plans, or "I stop" paralysis. They must freeze unsafe mutation, bind the work to a task and RUN, start authorized read-only triage, and continue through the safe recovery ladder until the site state is proven or an exact owner-only irreversible gate is reached.

This policy is a governance control only. It is not permission to touch product code, production or test sites, Docker, databases, Nginx/proxies, firewalls, PM2, DNS, SSL, object storage, Railway, secrets, workflow dispatch, or product master/main.

## P0 Owner Distress Signals

Treat the following as incident signals:

- "site broken"
- "client screaming"
- "production broken"
- "you destroyed the site"
- "panic"
- "karau" or "караул"
- repeated urgent distress
- any equivalent owner complaint that service is down or client impact exists

On detection, switch to `INCIDENT` profile and stop ordinary feature, test, or governance-deferred work that could continue unsafe mutation.

## Owner Message Contract

During active crisis, user-facing output is limited to:

```text
Fact: <known service state in one line>
Action: <current safe recovery action in one line>
Left: <none or exact owner-only irreversible blocker>
```

If no facts exist yet, the action must be authorized read-only triage. Do not ask the owner to choose routine technical steps that the authorized route can perform safely.

Blocked patterns:

- "I stop and do nothing" without a recovery route.
- repeated apologies or explanations as the main response.
- long internal reasoning dumps.
- asking the owner to select routine diagnostics.
- client-facing promises without green claim-ledger evidence.

## Freeze Means Controlled Recovery

Incident freeze stops unsafe mutation only. It must automatically start:

1. task and RUN binding;
2. read-only state capture;
3. blast-radius classification;
4. environment classification;
5. last-known-change ledger;
6. recovery option selection;
7. evidence receipt.

Read-only checks available through authorized AgentHub/MCP routes do not require owner confirmation.

## Environment Target Proof Gate

Before any operation, classify target environment as one of:

- `LOCAL_ONLY`
- `TEST_CONFIRMED`
- `PRODUCTION`
- `PROD_RISK`
- `UNKNOWN_ENVIRONMENT`

Rules:

- `master` or `main` in product repositories is `PROD_RISK` by default.
- GitHub workflow run, watch, or dispatch in a product repository is `PROD_RISK` unless `environment_target_proof` proves test-only and no production side effect.
- A workflow name containing "test" is not proof.
- A branch name containing "test" is not proof.
- Protected or product repository remote ambiguity is `PROD_RISK`.
- Missing proof blocks the operation and converts it into same-RUN PackFix for route discovery, not owner chat.

## Production Lock

Production mutation, production deploy, product `master`/`main` merge, workflow dispatch, rollback execution, DB/proxy/runtime mutation, and server writes require all of:

1. exact task id and RUN_ID;
2. valid `environment_target_proof`;
3. rollback/checkpoint plan;
4. impact analysis;
5. explicit owner phrase for that exact action, for example `разрешаю отгрузку на прод` or `разрешаю точечный rollback <target>`;
6. authorized worker route.

T0/T1 direct action is not sufficient.

## Safe Recovery Ladder

When owner distress reports a broken site:

1. Stop feature/test work.
2. Open or bind the P0 incident task after duplicate check.
3. Run read-only checks through authorized AgentHub/MCP route only.
4. Build change ledger: last PRs, commits, workflow runs, deploys, task ids, routes, and target environments.
5. Determine if production was touched.
6. If production was not touched, state evidence and return to the prior test task only after owner panic is resolved.
7. If production was touched, choose the smallest reversible recovery action.
8. If exact rollback is safe, authorized, and non-destructive, execute by scoped worker with checkpoint and validation.
9. If rollback touches DB, proxy, runtime, destructive, or global infrastructure, stop only with `OWNER_ONLY_IRREVERSIBLE_GATE` and one exact requested phrase.
10. Validate with user-visible/browser proof where in scope.

## Anti-Chaos Closure

A closed incident or governance task must not leave noisy PR, branch, task, or artifact tails:

- PR merged or explicitly closed, superseded, or quarantined.
- branch state recorded.
- `PR_QUEUE_REGISTER.md` updated when present.
- `ARTIFACT_REGISTER.md` and `INDEX.md` updated when present.
- no same-scope open duplicate PR/task remains.

## Test-First Product Rule

For StroyRemont-like product tasks:

- Work stays in test-only contour until browser/user acceptance on test is complete.
- The owner may be asked for a small test instruction only after the agent has prepared test state and exact path.
- Production release is a separate task/stage and requires explicit owner phrase.
- Client delivery text is forbidden until the claim ledger is green.
