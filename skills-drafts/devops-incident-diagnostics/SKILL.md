---
name: devops-incident-diagnostics
description: Provide a scoped DevOps incident worker workflow for Docker, systemd, ports, upstreams, and service dependencies without entering forbidden proxy, DB, firewall, secret, or unrelated-service zones.
owner_role: T2 DevOps Incident Worker
source_task: AH-511
status: draft
---

# DevOps Incident Diagnostics

## Purpose

Turn live infrastructure incidents into repeatable, evidence-first repair cycles. This skill is for a scoped worker, not T0.

## Trigger Conditions

- upstream returns 502, connection refused, timeout, or wrong backend;
- Docker container is absent, unhealthy, or not publishing the expected port;
- systemd bridge or socat unit points to stale target;
- service dependency is missing;
- host and Docker-network checks disagree.

## Forbidden Zones

Unless a separate exact gate authorizes it, do not:

- edit or inspect Nginx/NPM generated configs;
- exec into proxy-manager containers;
- query, dump, migrate, or inspect database contents;
- open firewall broadly;
- print secrets or env values;
- delete containers, volumes, images, or PM2 process entries;
- touch unrelated services.

## Diagnostic Order

1. Bind scope: upstream id, expected URL/socket, service owner, allowed actions, forbidden zones.
2. Inventory owner: compose path, container name, systemd unit, restart policy, network, port mapping.
3. Validate from host: TCP open, HTTP status, TLS mode when relevant.
4. Validate from caller network: Docker network namespace or application network that actually reaches the upstream.
5. Check dependency surface: required containers, sockets, volumes mounted, process present, restart policy.
6. Classify root cause:
   - stale route;
   - absent container;
   - missing port publication;
   - backend process down;
   - missing dependency;
   - forbidden-zone blocker;
   - unknown after bounded diagnostics.
7. Execute only the smallest typed restore action.
8. Re-run host and caller-network validation.
9. Record rollback, residual risk, and durable restart behavior.

## Required Output Matrix

| Upstream | Owner | Current state | Root cause | Restore action | Validation | Rollback | Residual |
|---|---|---|---|---|---|---|---|

## Restore Action Classes

- restart existing bridge unit;
- start existing compose stack;
- restore missing dependency container with existing volume and restart policy;
- publish missing expected host port in canonical compose;
- restart app process after dependency restoration;
- return typed blocker for DB/proxy/firewall/secret requirements.

## Evidence Required

- redacted commands or summaries;
- host validation;
- caller-network validation;
- service state;
- forbidden-zone statement;
- no-secret statement.

## Done Condition

`PASS` requires all scoped upstreams to have validation evidence or an explicit typed blocker. Green host checks alone are insufficient.
