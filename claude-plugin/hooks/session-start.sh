#!/usr/bin/env bash
# SessionStart hook — emits a JSON context block that Claude consumes on
# startup / resume. The block surfaces a one-line summary of the project's
# graph (if present) so Claude knows the structure before issuing reads.
set -euo pipefail

WORKSPACE="${CLAUDE_PROJECT_DIR:-$PWD}"
GRAPH="$WORKSPACE/graphy-out/graph.json"

emit() {
  # Single-line JSON envelope so we can build it without jq.
  local msg="$1"
  # Escape backslashes and double-quotes for embedding in a JSON string.
  msg="${msg//\\/\\\\}"
  msg="${msg//\"/\\\"}"
  printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$msg"
}

if [[ ! -f "$GRAPH" ]]; then
  emit "graphy: no graph yet for this workspace. Claude can build one with \`/graphy build\` or by issuing a Read; the PreToolUse hook will auto-build on the next file access."
  exit 0
fi

if ! command -v jq >/dev/null 2>&1; then
  emit "graphy: graph present at graphy-out/graph.json but jq is not installed; install jq for graph-summary context."
  exit 0
fi

# Pull cheap stats from the graph.
NODES=$(jq -r '.nodes | length' "$GRAPH" 2>/dev/null || echo 0)
EDGES=$(jq -r '.edges | length' "$GRAPH" 2>/dev/null || echo 0)
COMMS=$(jq -r '[.nodes[].community] | unique | length' "$GRAPH" 2>/dev/null || echo 0)
TOP=$(jq -r '
  .edges
  | group_by(.target)
  | map({id: .[0].target, hits: length})
  | sort_by(-.hits)
  | .[0:5]
  | map(.id)
  | join(", ")
' "$GRAPH" 2>/dev/null || echo "")

MSG="graphy: ${NODES} nodes / ${EDGES} edges / ${COMMS} communities in this workspace. Top inbound: ${TOP}. Query via the \`graphy\` MCP server (tools: stats, search_label, neighbors, query_node, shortest_path) instead of grepping when looking for symbols or callers."

jq -nc --arg msg "$MSG" '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":$msg}}'
