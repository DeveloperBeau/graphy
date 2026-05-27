# CLI modes

```
graphy <path>                      # one-shot pipeline (default)
graphy run <path>                  # same, explicit
graphy watch <path>                # rebuild on every change (notify + debounce)
graphy serve --graph graph.json    # MCP-style JSON-RPC server over stdio
graphy plugins list                # show registered language plugins
graphy plugins regenerate-manifest <dir>
graphy plugins install <dylib>
graphy doctor                      # version + arch
```

## `run`

Builds the graph once and exits. Flags:

| Flag                  | Effect                                                                       |
|-----------------------|------------------------------------------------------------------------------|
| `--out <DIR>`         | Write `graphy-out/` under `DIR` instead of `<path>`                          |
| `--docs`              | Include doc files (`md`/`mdx`/`rst`/`qmd`) — usually skipped                 |
| `--full`              | Force a full rebuild even when a prior graph exists                          |
| `--no-dedup`          | Disable entity deduplication                                                 |
| `--no-scc-expansion`  | Disable SCC expansion for delta-Louvain (cycle-aware clustering)             |
| `--no-hierarchical`   | Disable hierarchical Louvain level caching                                   |

## `watch`

`graphy watch <path>` runs the initial build then re-runs whenever a tracked file changes. Uses `notify` + a 250 ms debouncer; changes inside `graphy-out/` are ignored to avoid feedback loops.

## `serve`

`graphy serve --graph graph.json` reads JSON-RPC over stdin/stdout. Methods: `initialize`, `tools/list`, `tools/call`. Tools:

| Tool             | Input                                          | Returns                                                                 |
|------------------|------------------------------------------------|-------------------------------------------------------------------------|
| `stats`          | `{}`                                           | `{nodes, edges, communities}` for the loaded graph                      |
| `search_label`   | `{q: string, limit?: number}`                  | Up to `limit` (default 20) nodes whose label contains `q`               |
| `neighbors`      | `{id: string}`                                 | `{outgoing: [...], incoming: [...]}` for the given node id              |
| `query_node`     | `{id: string}`                                 | Full metadata for a single node                                         |
| `shortest_path`  | `{from: string, to: string}`                   | Array of node ids forming a shortest undirected path                    |

Node ids are `<source_file>::<symbol_name>` (e.g. `crates/graphy-core/src/cluster.rs::cluster`). Imports use `extern::<imported-path>`.

## `plugins`

| Subcommand                      | Purpose                                                                                       |
|---------------------------------|-----------------------------------------------------------------------------------------------|
| `plugins list`                  | Show every plugin currently registered through manifest discovery                             |
| `plugins regenerate-manifest`   | Re-scan a plugin directory and write a fresh `manifest.toml`                                  |
| `plugins install <dylib>`       | Copy a built plugin dylib into the user's plugin directory and regenerate the manifest        |

See [plugins.md](plugins.md) for the discovery order, manifest schema, and ABI.

## `doctor`

Prints `graphy <version>` and `rust target: <arch>`. Used by integrations to verify the binary is on `$PATH`.
