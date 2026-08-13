# graphy for Codex

Build and query a knowledge graph of any codebase from Codex. The plugin
auto-builds the graph in the background and exposes it over MCP, so Codex can
query symbols, callers, and dependencies instead of grepping.

## Prerequisites

Install the `graphy` binary first — the plugin runs it on disk.

- Release install: see the [graphy README](https://github.com/DeveloperBeau/graphy#install).
- Or `cargo install --path crates/graphy-cli` from a checkout.

The launcher looks in `~/.graphy/bin`, `~/.cargo/bin`, and `PATH`.

## Install

```
codex plugin marketplace add DeveloperBeau/graphy
codex plugin install graphy
```

## What it does

- Registers the `graphy` MCP server with five tools: `stats`, `search_label`,
  `neighbors`, `query_node`, `shortest_path`.
- A `SessionStart` hook builds the workspace graph in the background (or rebuilds
  it when source has changed).
- A `PostToolUse` hook rebuilds after edits; graphy's content-hash cache keeps
  this cheap.

The graph is written to `graphy-out/graph.json` in the workspace.
