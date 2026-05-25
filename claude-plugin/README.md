# graphy — Claude Code plugin

Auto-builds a knowledge graph of any code Claude reads, then exposes the graph through MCP tools so Claude can query symbols, callers, and call paths instead of grepping.

## What it ships

| Component        | What it does                                                                          |
|------------------|---------------------------------------------------------------------------------------|
| MCP server       | `graphy serve` spawned per workspace; exposes `stats`, `search_label`, `neighbors`, `query_node`, `shortest_path` |
| PreToolUse hook  | Before `Read` / `Glob` / `Grep`, build the graph in the background if it is missing or stale (default >10 min old) |
| PostToolUse hook | After `Edit` / `Write` / `MultiEdit`, kick off an async rebuild (graphy's hash cache makes this cheap) |
| SessionStart hook| Inject a one-line summary of the workspace's graph into Claude's context             |
| Slash commands   | `/graphy`, `/graphy-stats`, `/graphy-search`, `/graphy-neighbors`, `/graphy-path`, `/graphy-report` |
| Skill            | Teaches Claude when to query the graph instead of reading files                       |
| Subagent         | `graphy-explorer` — autonomous code-archaeology agent                                 |

## Prerequisites

1. The `graphy` binary on `$PATH`. Either:
   - `cargo install --path crates/graphy-cli` (from this repo), or
   - Download a release tarball and run `install.sh`.
2. Plugins available under `~/.graphy/plugins/` (the release tarball drops them there automatically; `cargo install` users can run `graphy plugins regenerate-manifest $(dirname $(which graphy))/../share/graphy/plugins`).

Check with `graphy doctor && graphy plugins list`.

## Install

```bash
# Method A: clone + symlink
git clone git@github.com:DeveloperBeau/graphy.git ~/code/graphy
ln -s ~/code/graphy/claude-plugin ~/.claude/plugins/graphy

# Method B: copy
cp -r ~/code/graphy/claude-plugin ~/.claude/plugins/graphy
```

Then in any Claude Code session run `/plugins` and enable `graphy`, or trust the manifest if Claude asks.

## How it behaves

The very first time Claude touches a file in a workspace it has never seen, the PreToolUse hook quietly kicks off `graphy <workspace>` in the background. The tool call (Read/Glob/Grep) proceeds immediately — Claude is not blocked. Within a couple of seconds the graph lands at `<workspace>/graphy-out/graph.json` and the `graphy` MCP server picks it up. From that point on, every MCP tool call returns fresh data.

Edits trigger a rebuild via the PostToolUse hook. graphy's content-hash cache means unchanged files are skipped, so the rebuild is almost free.

If you want the graph synchronously up-to-date before a query, run `/graphy` explicitly.

## Configuration

Hooks read these environment variables when set:

| Var                  | Purpose                                                 | Default |
|----------------------|---------------------------------------------------------|---------|
| `GRAPHY_BIN`         | Path to graphy binary                                   | `graphy` |
| `GRAPHY_VERBOSE`     | Log hook activity to stderr                             | unset    |
| `GRAPHY_MAX_AGE`     | Seconds before a graph counts as stale                  | `600`    |
| `GRAPHY_PLUGIN_PATH` | Override plugin discovery path passed to the MCP server | unset    |

## License

MIT.
