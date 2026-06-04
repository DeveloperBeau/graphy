# graphy for Codex

**Status: planned — target v0.4.0.**

A Codex plugin that wraps the same `graphy serve` MCP server as the Claude Code
plugin, so Codex can query the knowledge graph instead of grepping.

Planned surface:

- MCP server exposing `search_label`, `neighbors`, `query_node`, `shortest_path`,
  and `stats`.
- A skill that teaches Codex when to query the graph.
- Background-build hooks that keep the graph fresh as you read and edit files.

Install steps land here when the plugin ships.
