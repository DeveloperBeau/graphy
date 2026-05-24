#!/usr/bin/env bash
# PostToolUse hook for Edit / Write / MultiEdit.
#
# A file was just modified — invalidate any in-flight stale graph and
# kick off an async rebuild. graphy's content-hash cache means unchanged
# files are skipped, so the rebuild is cheap.
set -euo pipefail

WORKSPACE="${CLAUDE_PROJECT_DIR:-$PWD}"
OUT="$WORKSPACE/graphy-out"
LOCK="$OUT/.build.lock"
LOG="$OUT/.build.log"
GRAPHY_BIN="${GRAPHY_BIN:-graphy}"

command -v "$GRAPHY_BIN" >/dev/null 2>&1 || exit 0
[[ -d "$WORKSPACE" ]] || exit 0
mkdir -p "$OUT"

# If a build is already running, don't pile up another one.
if [[ -f "$LOCK" ]]; then
  pid="$(cat "$LOCK" 2>/dev/null || true)"
  if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
    exit 0
  fi
  rm -f "$LOCK"
fi

(
  echo $$ > "$LOCK"
  trap 'rm -f "$LOCK"' EXIT
  "$GRAPHY_BIN" "$WORKSPACE" --out "$WORKSPACE" >"$LOG" 2>&1 || true
) >/dev/null 2>&1 &
disown 2>/dev/null || true
exit 0
