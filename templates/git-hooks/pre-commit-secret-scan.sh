#!/usr/bin/env bash
set -euo pipefail

if ! command -v gitleaks >/dev/null 2>&1; then
  echo "BLOCKER_SCANNER_INSTALL_UNAVAILABLE: gitleaks is not installed." >&2
  exit 2
fi

gitleaks protect \
  --staged \
  --redact=100 \
  --exit-code 1
