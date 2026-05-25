---
description: Build or refresh the knowledge graph for the current workspace and surface the headline summary.
argument-hint: "[path]"
---

# /graphy

Build (or rebuild) a knowledge graph for the current Claude workspace and surface the headline summary.

Usage:

- `/graphy` — graph the current workspace (`$CLAUDE_PROJECT_DIR` or cwd).
- `/graphy <path>` — graph a specific directory.

The graph is written to `<workspace>/graphy-out/{graph.json, GRAPH_REPORT.md, graph.html}`. After the build, the `graphy` MCP server is automatically pointed at it, so subsequent tool calls (`stats`, `search_label`, `neighbors`, `query_node`, `shortest_path`) hit fresh data.

Steps:

1. Resolve the target path — `$ARGUMENTS` if non-empty, otherwise `$CLAUDE_PROJECT_DIR` (or cwd if unset).
2. Run `graphy <path>` via Bash. The CLI prints `scanned N files (M from cache) in Xms → N nodes, E edges, C communities`.
3. Read `<path>/graphy-out/GRAPH_REPORT.md` and quote the top god nodes back to the user.
4. Suggest the most useful follow-up depending on the report — usually one of:
   - `/graphy-search <name>` to look up a symbol
   - `/graphy-neighbors <id>` to inspect a high-degree node
   - Call the `graphy` MCP server's `shortest_path` tool to relate two nodes
