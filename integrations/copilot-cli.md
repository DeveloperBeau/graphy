# graphy for Copilot CLI

**Status: planned — target v0.6.0.**

A GitHub Copilot CLI plugin that wraps the same `graphy serve` MCP server as the
Claude Code plugin, so Copilot can query the knowledge graph instead of grepping.

Planned surface:

- MCP server exposing `search_label`, `neighbors`, `query_node`, `shortest_path`,
  and `stats`.
- A skill plus a `graphy-explorer` agent.
- Background-build hooks that keep the graph fresh as you read and edit files.

Install steps land here when the plugin ships.
