---
description: Show outgoing and incoming edges for a node in the workspace's knowledge graph.
argument-hint: "<node-id-or-label>"
---

# /graphy-neighbors

Show the outgoing + incoming edges of a node so you can see who calls it and what it depends on.

Usage:

- `/graphy-neighbors <node-id>` — exact id (typically `path/to/file.rs::symbol_name`).
- `/graphy-neighbors <label>` — fuzzy form; the command first resolves the label via `search_label`.

Steps:

1. If `$ARGUMENTS` contains `::` treat it as a node id; otherwise resolve via the MCP server's `search_label` tool and take the top match.
2. Call the `neighbors` MCP tool on that id.
3. Render outgoing edges grouped by relation (`calls`, `imports`, `references`), then incoming the same way.
4. Highlight any node that appears as the target of more than three different callers — that is usually a god-node candidate worth surfacing.
