#!/usr/bin/env bash
# PreToolUse hook for Read / Glob / Grep.
#
# Goal: when Claude is reading source for the first time in a workspace,
# build a knowledge graph in the background so subsequent MCP queries work.
#
# Stays silent on stdout/stderr unless GRAPHY_VERBOSE is set. Never blocks
# the tool call: if a build is already running we skip; if the graph is
# fresh relative to source files we skip.
set -euo pipefail

# shellcheck source=./_common.sh
source "${BASH_SOURCE%/*}/_common.sh"

WORKSPACE="${CLAUDE_PROJECT_DIR:-$PWD}"
OUT="$WORKSPACE/graphy-out"
GRAPH="$OUT/graph.json"
LOCK="$OUT/.build.lock"
LOG="$OUT/.build.log"
# Skip the `find` staleness probe for graphs younger than this floor.
# Defends against thrash when Claude reads many files in rapid succession.
GRAPHY_MIN_AGE="${GRAPHY_MIN_AGE:-30}"
GRAPHY_BIN="${GRAPHY_BIN:-graphy}"

command -v "$GRAPHY_BIN" >/dev/null 2>&1 || {
  graphy_log "graphy not on PATH; skipping"
  exit 0
}

[[ -d "$WORKSPACE" ]] || exit 0

# If the graph already exists, decide whether it is stale enough to rebuild.
if [[ -f "$GRAPH" ]]; then
  now="$(date +%s)"
  age=$(( now - $(graphy_mtime "$GRAPH") ))
  if (( age < GRAPHY_MIN_AGE )); then
    graphy_log "graph is ${age}s old (< ${GRAPHY_MIN_AGE}s floor); reusing"
    exit 0
  fi
  # Prune common heavy directories so `find` finishes in milliseconds on big
  # repos. We exit on the first newer source file — anything is enough to
  # justify a rebuild.
  newer="$(
    find "$WORKSPACE" \
      \( -name .git -o -name target -o -name node_modules \
         -o -name graphy-out -o -name dist -o -name build \
         -o -name .venv -o -name venv -o -name .next \
         -o -name __pycache__ -o -name .gradle -o -name .idea \) -prune \
      -o -type f -newer "$GRAPH" -print 2>/dev/null \
      | head -n 1 || true
  )"
  if [[ -z "$newer" ]]; then
    graphy_log "graph newer than every source file; reusing"
    exit 0
  fi
fi

mkdir -p "$OUT"

if ! graphy_acquire_lock "$LOCK"; then
  exit 0
fi

graphy_log "kicking off background build for $WORKSPACE"
graphy_fork_build "$WORKSPACE" "$WORKSPACE" "$LOCK" "$LOG"
exit 0
