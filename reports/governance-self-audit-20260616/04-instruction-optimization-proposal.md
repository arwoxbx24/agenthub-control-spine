# Instruction Optimization Proposal

## Goal

Cut always-loaded technical instruction volume by 15-35% with no loss of safety. Use English for technical rules. Keep Russian only for user-visible output requirements, quoted user text, task titles/descriptions intended for Russian users, and localized UI labels.

## Proposed Spine

Create one English canonical file, for example `governance/agenthub-runtime-policy-spine.md`, with these sections:

1. Authority and precedence.
2. Scope and no-touch rules.
3. AgentHub route requirements.
4. Forbidden zones.
5. Evidence and Done gates.
6. Language policy.
7. Efficiency policy: Ponytail/Caveman.
8. Recovery routes after hook denial.

Then shrink local AGENTS files to:

- source priority;
- link to spine;
- local-only narrowing rules;
- setup/test commands if needed.

## Compression Candidates

- Replace repeated DB/Docker/Nginx/secrets paragraphs with one forbidden-zone block plus examples.
- Replace repeated MCP-first wording with one route contract.
- Replace repeated model allowlist text with one helper-model contract.
- Replace repeated Done gate text with one evidence tuple schema.
- Move long operational examples from AGENTS into runbooks.
- Move incident history and rationale into reports/runbooks, not always-loaded instructions.

## Keep Explicit

Do not compress away:

- destructive action warnings;
- DB/Nginx/secrets forbidden zones;
- protected-link intake;
- no direct client project mutation;
- latest owner no-touch override;
- evidence-before-Done;
- exact model/fork restrictions for helpers.

## English-Only Technical Rule

Technical prompts, contracts, validators, dispatch briefs, task-service receipts, and runtime policies: English only.

Allowed Russian:

- user-facing chat;
- task titles/descriptions meant for Russian users;
- quoted user text;
- localized UI labels;
- citations or source excerpts that are originally Russian.

## Expected Savings

Conservative estimate: 15-25% from deduping repeated hard rules.

Aggressive estimate: 25-35% if long examples and incident narratives move from always-loaded AGENTS into on-demand runbooks.
