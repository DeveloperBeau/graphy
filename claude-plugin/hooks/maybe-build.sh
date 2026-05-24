#!/usr/bin/env bash
# PreToolUse hook for Read / Glob / Grep.
#
# Goal: when Claude is reading source for the first time in a workspace,
# build a knowledge graph in the background so subsequent MCP queries work.
#
# Stays silent on stdout/stderr unless GRAPHY_VERBOSE is set. Never blocks
# the tool call: if a build is already running we skip; if the workspace
# already has a fresh graph (newer than the newest source file) we skip.
set -euo pipefail

WORKSPACE="${CLAUDE_PROJECT_DIR:-$PWD}"
OUT="$WORKSPACE/graphy-out"
GRAPH="$OUT/graph.json"
LOCK="$OUT/.build.lock"
LOG="$OUT/.build.log"
MAX_AGE_SECONDS="${GRAPHY_MAX_AGE:-600}"   # rebuild if older than 10 min
GRAPHY_BIN="${GRAPHY_BIN:-graphy}"

log() {
  [[ -n "${GRAPHY_VERBOSE:-}" ]] && echo "[graphy-hook] $*" >&2
  return 0
}

command -v "$GRAPHY_BIN" >/dev/null 2>&1 || {
  log "graphy not on PATH; skipping"
  exit 0
}

[[ -d "$WORKSPACE" ]] || exit 0

# If a build is already in progress, leave it alone.
if [[ -f "$LOCK" ]]; then
  pid="$(cat "$LOCK" 2>/dev/null || true)"
  if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
    log "build already running (pid $pid)"
    exit 0
  fi
  rm -f "$LOCK"
fi

# If graph exists and is "fresh enough", skip.
if [[ -f "$GRAPH" ]]; then
  graph_mtime="$(stat -f %m "$GRAPH" 2>/dev/null || stat -c %Y "$GRAPH" 2>/dev/null || echo 0)"
  now="$(date +%s)"
  age=$(( now - graph_mtime ))
  if (( age < MAX_AGE_SECONDS )); then
    log "graph is ${age}s old; reusing"
    exit 0
  fi
fi

mkdir -p "$OUT"
log "kicking off background build for $WORKSPACE"

# Fire and forget; nohup so the build survives the hook's exit.
(
  echo $$ > "$LOCK"
  trap 'rm -f "$LOCK"' EXIT
  "$GRAPHY_BIN" "$WORKSPACE" --out "$WORKSPACE" >"$LOG" 2>&1 || true
) >/dev/null 2>&1 &
disown 2>/dev/null || true
exit 0
