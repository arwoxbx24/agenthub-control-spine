# AgentHub PR Branch Noise Audit 2026-06-10

## Current GitHub state

Branch search returned 104 branch names. Open PR readback returned:

| PR | Branch | State | Noise class | Decision |
|---|---|---|---|---|
| `#149` | `agenthub/control-spine-branch-hygiene-20260610` | open, mergeable, not merged | ACTIVE_CONTROL | Keep as the only branch-hygiene cleanup contour. |
| `#148` | `agenthub-global-correction-contour-20260610` | open | ACTIVE_CONTROL / prompt architecture | Do not use as branch-hygiene execution point. |
| `#147` | `repo-bridge-contract-20260607` | open | BLOCKED_WITH_ARTIFACT | Do not use as branch-hygiene execution point. |

## Branch noise facts

- `main` must remain protected.
- Fresh 2026-06-06 through 2026-06-10 branches must remain protected.
- Open PR branches must remain protected.
- Review-before-delete branches must remain until lifecycle decision is registered.
- This audit did not delete any branch.

## PR #149 cleanup facts

PR #149 is not done. Current known state: `deletions=0`, branch cleanup not executed, receipt updated with candidates/classification but no remote deletion proof.

## Review-before-delete branches

The known 15 review-before-delete branches from PR #149 remain review/quarantine/archive territory until separate evidence proves supersession or merge requirement. This audit does not override PR #149 classifications.

## Prompt/report noise facts

One-time prompts and receipts must not become active instruction sources. Current repository policy says reports are evidence, receipts are proof, and prompts are consumed unless `safe_to_replay=true` is explicit.

## Noise reduction rule

Do not create more cleanup prompts for PR #149. The next useful action is executable repair: refresh active MCP process, validate delete route, then continue PR #149 scoped deletion plan.
