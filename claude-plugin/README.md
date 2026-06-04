# graphy — Claude Code plugin

Auto-builds a knowledge graph of any code Claude reads, then exposes the graph through MCP tools so Claude can query symbols, callers, and call paths instead of grepping.

## What it ships

| Component        | What it does                                                                          |
|------------------|---------------------------------------------------------------------------------------|
| MCP server       | `graphy serve` spawned per workspace; exposes `stats`, `search_label`, `neighbors`, `query_node`, `shortest_path` |
| PreToolUse hook  | Before `Read` / `Glob` / `Grep`, build the graph in the background if it is missing or stale (default >10 min old) |
| PostToolUse hook | After `Edit` / `Write` / `MultiEdit`, kick off an async rebuild (graphy's hash cache makes this cheap) |
| SessionStart hook| Inject a one-line summary of the workspace's graph into Claude's context             |
| Slash commands   | `/graphy`, `/graphy-stats`, `/graphy-search`, `/graphy-neighbors`, `/graphy-path`, `/graphy-report`, `/setup-graphy` |
| Skill            | Teaches Claude when to query the graph instead of reading files                       |
| Subagent         | `graphy-explorer` — autonomous code-archaeology agent                                 |

## Prerequisites

1. The `graphy` binary on `$PATH`. Either:
   - `cargo install --path crates/graphy-cli` (from this repo), or
   - Download a release tarball and run `install.sh`.
2. Plugins available under `~/.graphy/plugins/` (the release tarball drops them there automatically; `cargo install` users can run `graphy plugins regenerate-manifest $(dirname $(which graphy))/../share/graphy/plugins`).

Check with `graphy doctor && graphy plugins list`.

## Install

Installed through the marketplace manifest at the repo root (`.claude-plugin/marketplace.json`):

```
# From GitHub
/plugin marketplace add DeveloperBeau/graphy
/plugin install graphy@graphy

# From a local checkout
git clone git@github.com:DeveloperBeau/graphy.git ~/code/graphy
/plugin marketplace add ~/code/graphy
/plugin install graphy@graphy
```

Choose **user** scope when prompted to enable graphy in every project. Run `/plugins` to confirm. When developing against a local checkout, refresh the cached snapshot after edits with `/plugin marketplace update graphy`.

## How it behaves

The very first time Claude touches a file in a workspace it has never seen, the PreToolUse hook quietly kicks off `graphy <workspace>` in the background. The tool call (Read/Glob/Grep) proceeds immediately — Claude is not blocked. Within a couple of seconds the graph lands at `<workspace>/graphy-out/graph.json`.

The MCP server tolerates a missing graph at startup — it serves an empty index until the file appears, then hot-reloads whenever the file changes on disk. There is no need to restart the Claude session after the first build, and rebuilds triggered by the PostToolUse hook show up on the next MCP tool call.

The PreToolUse hook decides whether to rebuild by checking whether any source file under the workspace is newer than `graph.json`. Heavy directories (`.git`, `target`, `node_modules`, `graphy-out`, `dist`, `build`, `.venv`, `.next`, `__pycache__`, `.gradle`, `.idea`) are pruned so the check is fast on big repos. A 30-second minimum-age floor stops the probe from running on very fresh graphs.

Edits trigger a rebuild via the PostToolUse hook. graphy's content-hash cache means unchanged files are skipped, so the rebuild is almost free. Concurrent hook invocations are serialised by an atomic lock under `graphy-out/.build.lock`; stale locks (dead PIDs or anything older than 30 minutes) are reclaimed automatically.

If you want the graph synchronously up-to-date before a query, run `/graphy` explicitly.

## Configuration

Hooks read these environment variables when set:

| Var                          | Purpose                                                            | Default |
|------------------------------|--------------------------------------------------------------------|---------|
| `GRAPHY_BIN`                 | Path to graphy binary                                              | `graphy` |
| `GRAPHY_VERBOSE`             | Log hook activity to stderr                                        | unset    |
| `GRAPHY_MIN_AGE`             | Seconds a graph must live before staleness is re-checked           | `30`     |
| `GRAPHY_LOCK_STALE_SECONDS`  | Build-lock age (seconds) after which a stuck lock is reclaimed     | `1800`   |
| `GRAPHY_PLUGIN_PATH`         | Override plugin discovery path passed to the MCP server            | unset    |

## License

MIT.
