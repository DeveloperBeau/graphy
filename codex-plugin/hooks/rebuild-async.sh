#!/usr/bin/env bash
# Codex PostToolUse hook for apply_patch / Edit / Write.
#
# A file was just modified — kick off an async rebuild. graphy's content-hash
# cache means unchanged files are skipped, so the rebuild is cheap.
set -euo pipefail

# shellcheck source=./_common.sh
source "${BASH_SOURCE%/*}/_common.sh"

WORKSPACE="$PWD"
OUT="$WORKSPACE/graphy-out"
LOCK="$OUT/.build.lock"
LOG="$OUT/.build.log"
GRAPHY_BIN="${GRAPHY_BIN:-graphy}"

command -v "$GRAPHY_BIN" >/dev/null 2>&1 || exit 0
[[ -d "$WORKSPACE" ]] || exit 0
mkdir -p "$OUT"

if ! graphy_acquire_lock "$LOCK"; then
  exit 0
fi

graphy_fork_build "$WORKSPACE" "$WORKSPACE" "$LOCK" "$LOG"
exit 0
