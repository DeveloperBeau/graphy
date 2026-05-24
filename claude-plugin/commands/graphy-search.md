---
description: Substring-search the current workspace's knowledge graph for symbols matching a query.
argument-hint: "<query>"
---

# /graphy-search

Substring-search every node label in the current workspace's graph and return the top matches with their source location.

Usage:

- `/graphy-search <query>` — case-insensitive contains-match over node labels.

Steps:

1. Confirm a graph exists at `$CLAUDE_PROJECT_DIR/graphy-out/graph.json`. If not, run `/graphy` first.
2. Call the `graphy` MCP server's `search_label` tool with `{ "q": "$ARGUMENTS", "limit": 20 }`.
3. Render the matches as a short table: label · kind · `source_file:source_location`.
4. If a single match clearly dominates, also call `neighbors` on its id and append the top three inbound + outbound edges.

Prefer this over `Grep` for symbol lookups — it operates on extracted definitions instead of raw text, so it filters out comments, string literals, and identifier substrings.
