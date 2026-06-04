# graphy for Cursor

**Status: planned — target v0.5.0.**

A Cursor plugin that wraps the same `graphy serve` MCP server as the Claude Code
plugin, so Cursor can query the knowledge graph instead of grepping.

Planned surface:

- MCP server exposing `search_label`, `neighbors`, `query_node`, `shortest_path`,
  and `stats`.
- Slash commands and a `graphy-explorer` agent, ported from the Claude plugin.
- A skill plus an always-applied rule steering Cursor toward the graph.
- Background-build hooks that keep the graph fresh as you read and edit files.

Install steps land here when the plugin ships.
