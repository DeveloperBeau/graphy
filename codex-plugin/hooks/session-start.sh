#!/usr/bin/env bash
# Codex SessionStart hook.
#
# Codex has no read-tool hook, so this is where graphy ensures a fresh graph
# exists: if the workspace has no graph (or the graph is older than its source)
# kick off a background build so the graphy MCP tools have data to answer with.
# Never blocks the session; silent unless GRAPHY_VERBOSE is set.
set -euo pipefail

# shellcheck source=./_common.sh
source "${BASH_SOURCE%/*}/_common.sh"

WORKSPACE="$PWD"
OUT="$WORKSPACE/graphy-out"
GRAPH="$OUT/graph.json"
LOCK="$OUT/.build.lock"
LOG="$OUT/.build.log"
GRAPHY_BIN="${GRAPHY_BIN:-graphy}"

command -v "$GRAPHY_BIN" >/dev/null 2>&1 || {
  graphy_log "graphy not on PATH; skipping"
  exit 0
}

[[ -d "$WORKSPACE" ]] || exit 0

# If a graph exists, only rebuild when a source file is newer than it. Prune
# heavy dirs so the find probe finishes in milliseconds on big repos.
if [[ -f "$GRAPH" ]]; then
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
