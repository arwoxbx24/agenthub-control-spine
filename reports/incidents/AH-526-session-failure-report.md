# AH-526 Session Failure Report

## Status
This report documents the AH-526 session failure. It is written as a strict postmortem for Team Lead review and follow-up hardening.

## User Request
The user required processing only the uploaded/source files. The source rows had to remain the only product-position source. Bitrix/catalog data could be used only for matching and comparison. No new product rows could be added from catalog data.

Required output groups:

1. Bitrix/marketplace licenses with discount.
2. Bitrix/marketplace licenses without discount.
3. Implementation services.

Additional requirements:

- delete rows with empty `Наименование`;
- keep user-authored descriptions as the base;
- do not invent unrelated descriptions;
- do not include partner prices;
- do not damage client-facing price formatting;
- remove unused license columns such as root section, section id, and plain section path;
- keep final task attachments clean and current only.

## Failures

1. The task was initially treated as catalog export/enrichment instead of user-file-only reconciliation.
2. The agent incorrectly assumed the protected links had to point to catalog files.
3. The live short links were valid, but the local protected-link index was stale and resolved to old objects. The stale local result was trusted too early.
4. The agent reported link/source blockers incorrectly before diagnosing the stale-index mismatch.
5. The agent used older AH-525/AH-526 artifacts as substitutes, despite the user explicitly requiring the uploaded files only.
6. The first generated descriptions included irrelevant or speculative content.
7. The task was moved to `Test` too early.
8. The task was moved to `Done` too early.
9. Obsolete attachments remained in the task, which hid the actual file from the user.
10. A delivered archive was incomplete: it contained services and no-discount licenses but missed the Bitrix/marketplace discount-license file.
11. A later attempted repair used an older catalog-export discount source and introduced price-format risk such as decimal-padded values like `6990,00000000`.
12. The final user-facing link path exposed raw/internal YouTrack URL surfaces at least once instead of only the canonical `yt.b244.ru` domain.
13. The chat contained too much internal tool and routing detail, which increased user confusion and contributed to a platform risk warning.

## User Impact

- Client delivery was delayed.
- The user had to repeat the same instruction many times.
- The user saw wrong or incomplete files.
- The task state became untrustworthy because `Test` and `Done` were used before acceptance was actually met.
- The final attachment state was confusing because obsolete files were visible until manually removed.
- The user had to spend attention on process failures instead of validating the client files.

## Root Causes

1. No hard `USER_FILE_SOURCE_OF_TRUTH` gate.
2. No input manifest gate requiring all three file groups before generation.
3. No stale-link-index detection when local protected-link records disagree with live short-link behavior.
4. No pre-delivery archive manifest validation.
5. No price-format preservation validator.
6. No description provenance validator.
7. Weak attachment hygiene before user handoff.
8. Weak user-facing URL sanitizer for YouTrack/YouTracker attachment links.
9. Done gate checked evidence existence but not sufficient artifact correctness.
10. The agent responded with internal process details during a high-pressure delivery task.

## Required System Fixes

### 1. Source-of-truth gate
Add a gate for file/catalog reconciliation tasks:

- every output row must trace to a source row;
- catalog/Bitrix rows cannot be added unless explicitly requested;
- empty `Наименование` rows must be removed and counted;
- output must retain source row identity.

### 2. Input manifest gate
Before generating any archive, detect and require:

- discount licenses;
- no-discount licenses;
- implementation services.

If any group is missing, block delivery and keep the task out of `Done`.

### 3. Link resolver hardening
Protected-link flow must detect stale local records:

- if local index returns an old object but live short-link points elsewhere, treat local index as stale;
- use a controlled live-resolution fallback;
- record the mismatch as validation evidence;
- do not tell the user the link is broken until both paths are checked.

### 4. Archive manifest validator
Before attaching or closing:

- expected files are present;
- expected file categories are present;
- row counts are sane;
- no obsolete files are included;
- final attachment count is clean.

### 5. Price-format validator
Client-facing price values must preserve the uploaded/source file format. Catalog-export decimal padding must not enter final files unless it was present in the source.

### 6. Description provenance validator
Description text must be from:

- user-authored source text;
- allowed matched source text;
- explicitly approved catalog comparison text.

Speculative marketing copy, unrelated integrations, or invented product content must be blocked.

### 7. YouTrack URL sanitizer
User-facing outputs must never show raw IP, localhost, or loopback YouTrack links. Use only:

- `https://yt.b244.ru/...`; or
- issue id only when a canonical URL cannot be verified.

### 8. Attachment hygiene gate
Before user handoff:

- remove obsolete attachments;
- leave only the current final artifact;
- verify downloadable canonical link;
- block closure if stale attachments remain.

### 9. Quiet final mode
For urgent client-delivery tasks, user-facing chat must contain only:

- current status;
- final file link or exact blocker;
- no internal receipt/tool/storage details.

## Immediate Remediation Done In Session

- The premature `Done` state was reversed.
- The stale-link issue was identified.
- Live user-source files were downloaded.
- A complete archive was rebuilt with all three groups.
- Old wrong attachment was removed.
- A replacement final archive was attached.
- A local runtime patch was started to prefer canonical `yt.b244.ru` issue URLs and to block raw YouTrack hosts in final reports.

## Remaining Work

The remediation must be converted into tested runtime controls. A separate implementation task should add validators and fixtures for:

- three expected file groups;
- duplicate short link;
- stale local protected-link record;
- missing category;
- obsolete attachments;
- raw YouTrack URL leakage;
- decimal-padded price contamination;
- invented description text.

## Acceptance Criteria For Permanent Fix

- Missing discount-license group blocks delivery.
- Decimal-padded catalog price contamination blocks delivery when the uploaded source had plain prices.
- Raw YouTrack URLs block final report output.
- Obsolete task attachments block closure.
- Stale protected-link local index is detected and repaired before declaring a link broken.
- `Done` is impossible until source traceability, archive manifest, attachment hygiene, and user confirmation are all present.

## Confidentiality

This report intentionally excludes secrets, tokens, raw webhook values, and private credential material.
