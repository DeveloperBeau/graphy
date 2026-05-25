---
description: Find the shortest call/import path between two nodes in the knowledge graph.
argument-hint: "<from> <to>"
---

# /graphy-path

Find the shortest path (undirected BFS over calls + imports + references) between two nodes.

Usage:

- `/graphy-path <from-id> <to-id>` — both arguments are full ids (or labels that resolve uniquely).

Steps:

1. Split `$ARGUMENTS` on whitespace into `from` and `to`. If either lacks `::`, resolve via `search_label` and take the top match.
2. Call the `shortest_path` MCP tool with `{ "from": from_id, "to": to_id }`.
3. Render the resulting array as a chain: `A → B → C → D`. Cite source locations for each hop.
4. If the path is empty, say so explicitly — the two nodes are in different connected components and probably do not interact.
