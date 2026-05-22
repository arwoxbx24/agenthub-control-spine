#!/usr/bin/env bash
set -euo pipefail

if ! command -v gitleaks >/dev/null 2>&1; then
  echo "BLOCKER_SCANNER_INSTALL_UNAVAILABLE: gitleaks is not installed." >&2
  exit 2
fi

remote_name="${1:-origin}"
remote_url="${2:-unknown}"

while read -r local_ref local_sha remote_ref remote_sha; do
  if [[ "$local_sha" =~ ^0+$ ]]; then
    continue
  fi

  if [[ "$remote_sha" =~ ^0+$ ]]; then
    log_opts="$local_sha"
  else
    log_opts="$remote_sha..$local_sha"
  fi

  echo "Running redacted secret scan before push to ${remote_name} (${remote_ref})"
  gitleaks detect \
    --source . \
    --log-opts "$log_opts" \
    --redact=100 \
    --exit-code 1
done

true
