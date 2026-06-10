# AgentHub Critical Gates Kept 2026-06-10

The self-healing run did not remove broad safety controls.

## Kept gates

| Gate | Decision | Reason |
|---|---|---|
| Secret/token/private-key/env dump protection | keep | Critical safety boundary. |
| Docker/DB/proxy/firewall/DNS/SSL mutation denial | keep | Not needed for repository branch cleanup. |
| Personal repo target denial | keep | Canonical repo is `arwoxbx24/agenthub-control-spine`. |
| Main branch protection | keep | Irreversible branch safety. |
| Open PR branch protection | keep | Prevents deleting active PR heads. |
| Protected branch list | keep | Explicit branch safety. |
| Fresh branch protection | keep | Current-week work must not be deleted. |
| Expected SHA check | keep | Prevents deleting moved branches. |
| Task/RUN readback for mutation | keep | Prevents ad hoc deletion. |
| No fake Done | keep | `deletions=0` means branch cleanup is not complete. |

## Boundary

This repair branch is repository report evidence only. It does not authorize runtime, product, Docker, database, proxy, firewall, DNS, SSL, secret, or broad destructive cleanup work.
