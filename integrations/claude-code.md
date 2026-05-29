# Claude Code

Status: **v1 (stable)**. Source: [`claude-plugin/`](../claude-plugin/).

graphy ships as a Claude Code plugin that auto-builds a knowledge graph of any workspace Claude touches and exposes it through MCP tools, slash commands, a skill, and an autonomous subagent. The result: Claude asks "where is `X` defined" or "what calls `Y`" by querying the graph instead of grepping.

## What you get

| Surface | What it is |
|---------|------------|
| MCP server | `graphy serve` spawned per workspace. Tools: `stats`, `search_label`, `neighbors`, `query_node`, `shortest_path`. |
| PreToolUse hook | Before `Read` / `Glob` / `Grep`, builds the graph in the background if it is missing or stale. |
| PostToolUse hook | After `Edit` / `Write` / `MultiEdit`, kicks off an async rebuild. graphy's content-hash cache makes this nearly free. |
| SessionStart hook | Injects a one-line workspace summary (nodes / edges / communities / top inbound nodes) into Claude's startup context. |
| Slash commands | `/graphy`, `/graphy-stats`, `/graphy-search`, `/graphy-neighbors`, `/graphy-path`, `/graphy-report`. |
| Skill (`graphy`) | Teaches Claude when to query the graph instead of reading files. |
| Subagent (`graphy-explorer`) | Autonomous code-archaeology agent for "how does X work" / "what calls Y" questions. |

## Prerequisites

1. **`graphy` binary on `$PATH`.** Either:
   - `cargo install --path crates/graphy-cli` (from this repo), or
   - Download a release tarball from the [releases page](https://github.com/DeveloperBeau/graphy/releases) and run `install.sh`.
2. **Language plugins discoverable.** The release tarball drops them under `~/.graphy/plugins/` automatically. `cargo install` users can run:
   ```bash
   graphy plugins regenerate-manifest $(dirname $(which graphy))/../share/graphy/plugins
   ```
3. **`jq`** (optional, recommended). The SessionStart hook uses it to summarize the graph; without it the summary is skipped but the rest of the integration still works.

Verify everything resolves:

```bash
graphy doctor && graphy plugins list
```

You should see a version line and a table listing 30+ language plugins.

## Install

graphy is distributed as a Claude Code plugin through a marketplace manifest (`.claude-plugin/marketplace.json` at the repo root). Add the marketplace, then install the plugin:

```
# From GitHub (most users)
/plugin marketplace add DeveloperBeau/graphy
/plugin install graphy@graphy

# From a local checkout (development — install from your own source)
git clone git@github.com:DeveloperBeau/graphy.git ~/code/graphy
/plugin marketplace add ~/code/graphy
/plugin install graphy@graphy
```

Choose **user** scope when prompted to make graphy available in every project, or **local** to scope it to the current project. Run `/plugins` afterward to confirm it is enabled.

While developing against a local checkout, the marketplace caches a snapshot of your source. After editing the plugin, refresh it with `/plugin marketplace update graphy` and reinstall.

## Configuration

The hooks and MCP server read these environment variables. All have safe defaults; you only need to set them to deviate.

| Var | Purpose | Default |
|-----|---------|---------|
| `GRAPHY_BIN` | Path to the `graphy` binary | `graphy` (resolved via `$PATH`) |
| `GRAPHY_VERBOSE` | Log hook activity to stderr | unset |
| `GRAPHY_MAX_AGE` | Seconds before a cached graph counts as stale and triggers a rebuild | `600` |
| `GRAPHY_PLUGIN_PATH` | Override plugin discovery path passed to the MCP server | unset (falls back to `~/.graphy/plugins/`) |

These can be set in your shell profile or, for per-workspace overrides, in `.envrc` / `.env` picked up by your shell.

## Workflow

### First time in a new workspace

1. You open Claude Code in a repo it has never seen.
2. Claude issues its first `Read`, `Glob`, or `Grep`.
3. The PreToolUse hook spots the missing graph and forks `graphy <workspace>` in the background. The Read proceeds immediately — Claude is never blocked.
4. Within a few seconds the graph lands at `<workspace>/graphy-out/graph.json`.
5. The MCP server picks it up on the next tool call. From then on, every MCP query returns fresh data.

### As you edit

- The PostToolUse hook fires after each `Edit` / `Write` / `MultiEdit` and re-runs the pipeline asynchronously.
- graphy's content-hash cache skips unchanged files, so the rebuild is typically tens of milliseconds.
- A lock under `graphy-out/.build.lock` serialises concurrent rebuilds; stale locks from dead processes are reclaimed automatically.

### When you want a synchronous build

Run `/graphy` explicitly. It rebuilds the graph in the foreground and prints the headline summary (god nodes, ambiguous edges, community count).

## Slash command reference

| Command | What it does |
|---------|--------------|
| `/graphy [path]` | Build (or rebuild) the graph for the current workspace (or `path`) and print the summary. |
| `/graphy-stats` | One-paragraph counts: nodes, edges, communities. |
| `/graphy-search <query>` | Case-insensitive substring search over node labels. Prefer this over `Grep` for symbol lookups. |
| `/graphy-neighbors <id-or-label>` | Outgoing + incoming edges of a node, grouped by relation. Surfaces god-node candidates. |
| `/graphy-path <from> <to>` | Shortest undirected path between two nodes (BFS over `calls` + `imports` + `references`). |
| `/graphy-report` | Quote `GRAPH_REPORT.md` verbatim with follow-up suggestions. |

Node ids look like `<source_file>::<symbol_name>` (for example `crates/graphy-core/src/cluster.rs::cluster`). Imports use `extern::<imported-path>`. The MCP `search_label` tool resolves labels to ids, so most commands accept either form.

## When to query the graph vs read files

Reach for graphy first whenever you would otherwise:

- Grep for a symbol name to find its definition or callers.
- Read a directory tree to figure out which files implement a feature.
- Trace how data flows between two modules.
- Audit which third-party packages a file depends on.
- Spot god-objects, high-coupling hotspots, or hidden cycles.

The graph is cheaper to query than re-reading files, deduplicates results across re-exports, and produces typed edges (`calls`, `imports`, `references`, `inherits`, `implements`, `contains`) so the answer is precise.

`Read` is still the right tool when you need the actual source text or to verify a subtle semantic claim — the graph tells you *where* to read, not *what* the code does at a statement level.

## Confidence labels

Every edge carries a confidence label so Claude (and you) can weigh the answer:

- `EXTRACTED` — explicitly stated in the source (an `import`, `#include`, `@import`, …).
- `INFERRED` — second-pass call-graph match (the callee's leaf name matches a defined symbol in the workspace).
- `AMBIGUOUS` — flagged for human review (e.g. two `helper` functions in different modules).

The skill teaches Claude to mention confidence when relevant, especially `INFERRED` matches that may collide on leaf names.

## Troubleshooting

**`/plugins` does not list `graphy`.**
Confirm the marketplace was added (`/plugin marketplace list` should show `graphy`) and that the install succeeded (`/plugin install graphy@graphy`). For a local checkout, point `/plugin marketplace add` at the repo root — the directory containing `.claude-plugin/marketplace.json` — not at `claude-plugin/`.

**MCP tools come back empty (`{nodes: 0, edges: 0, communities: 0}`).**
The background build hasn't landed yet (give it a couple of seconds and retry), or the build failed. Tail `graphy-out/.build.log` for the failure.

**The MCP server crashed on session start.**
The current stable release exits if `graph.json` is missing at startup. Workaround: run `/graphy` once to build the graph, then restart the Claude Code session so the MCP server can spawn against an existing file. A fix that makes the server tolerate missing graphs is in flight.

**Hooks do nothing.**
Set `GRAPHY_VERBOSE=1` in your shell, restart Claude Code, and watch stderr — the hooks log every decision (skipping vs forking, lock state, …).

**Rebuilds keep firing on every Read.**
The default `GRAPHY_MAX_AGE` of `600` seconds counts the graph as stale after ten minutes. If your workspace is large enough that ten minutes feels too aggressive, raise it: `export GRAPHY_MAX_AGE=3600`.

**The graph is unsymbolicated / wrong language detected.**
Run `graphy plugins list` — the language plugin for that file's extension must be registered. If it is missing, regenerate the manifest against the directory that contains the `.dylib`/`.so` files.

**`graphy-out/` ends up in my git diff.**
Add `graphy-out/` to your `.gitignore`. graphy never tracks it for you; it is build output.

## Uninstall

```
/plugin uninstall graphy@graphy
/plugin marketplace remove graphy
```

Optionally also remove generated graphs:

```bash
find . -type d -name graphy-out -prune -exec rm -rf {} +
```

## See also

- Top-level [README](../README.md) — pipeline overview, language coverage, MCP serve details.
- [`claude-plugin/`](../claude-plugin/) — the plugin source: hooks, slash commands, skill, agent prompt, manifest.
