# graphy for Codex

**Status: beta.**

A Codex plugin that wraps the same `graphy serve` MCP server as the Claude Code
plugin, so Codex can query the knowledge graph instead of grepping.

## Install

Install the `graphy` binary first (see the [main README](../README.md#install)),
then:

```
codex plugin marketplace add DeveloperBeau/graphy
codex plugin install graphy
```

## Surface

- **MCP server `graphy`** — tools `stats`, `search_label`, `neighbors`,
  `query_node`, `shortest_path`.
- **Skill** — teaches Codex when to query the graph instead of reading files.
- **Hooks** — `SessionStart` builds the workspace graph in the background (or
  rebuilds it when source changed); `PostToolUse` (apply_patch / Edit / Write)
  rebuilds after edits.

## Smoke test

1. `codex plugin install ./codex-plugin` from a graphy checkout.
2. Open a workspace and start a Codex session.
3. After a moment, ask Codex to call the `graphy` `stats` tool; it should report
   non-zero nodes once the background build finishes.
4. `graphy-out/graph.json` should exist in the workspace.
