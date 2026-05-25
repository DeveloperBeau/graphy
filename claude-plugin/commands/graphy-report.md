---
description: Show the human-readable knowledge graph report for the current workspace.
---

# /graphy-report

Print the GRAPH_REPORT.md for the current workspace, surfacing god nodes and ambiguous-edge counts at a glance.

Usage:

- `/graphy-report` — no arguments. Reads `$CLAUDE_PROJECT_DIR/graphy-out/GRAPH_REPORT.md`.

Steps:

1. If the report does not exist, run `/graphy` first.
2. Read and quote the report verbatim.
3. After the quote, suggest follow-ups based on what stands out — high-degree nodes worth inspecting via `/graphy-neighbors`, ambiguous edges that need human review, communities that might map to architectural boundaries.
