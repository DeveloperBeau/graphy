---
description: Show top-level stats for the workspace's knowledge graph.
---

# /graphy-stats

Quick stats: total nodes, edges, communities. No arguments.

Steps:

1. Call the `graphy` MCP server's `stats` tool.
2. Render the result as a one-paragraph summary and suggest the next move (search a symbol, inspect a god node, or rebuild the graph if numbers look stale).
