---
name: graphy
description: Build and query a knowledge graph of any codebase via the graphy MCP server. Use whenever you need to locate a symbol, trace a call chain, find callers, audit imports, or understand module boundaries — instead of grepping or reading files blindly.
---

# graphy

graphy turns a folder of source code into a structured knowledge graph: nodes are top-level declarations (functions, classes, structs, modules, …) and edges are imports, calls, and explicit references. Once a workspace has been graphed, you can query it through the `graphy` MCP server's tools instead of grepping.

The plugin auto-builds the graph at session start and rebuilds in the background after edits, so the MCP tools are usually fresh.

## When to use this skill

Reach for graphy first whenever you would otherwise:

- Grep for a symbol name to find its definition or callers
- Read a directory tree to figure out what files implement a feature
- Trace how data flows between two modules
- Audit which third-party packages a file depends on
- Spot god-objects, high-coupling hotspots, or hidden cycles

The graph is cheaper to query than re-reading files, deduplicates results across re-exports, and produces typed edges (`calls`, `imports`, `references`) so the answer is precise.

## Tools

The `graphy` MCP server exposes five tools. Use them through the standard MCP tool-call mechanism.

| Tool             | Input                                          | Returns                                                                 |
|------------------|------------------------------------------------|-------------------------------------------------------------------------|
| `stats`          | `{}`                                           | `{nodes, edges, communities}` for the loaded graph                      |
| `search_label`   | `{q: string, limit?: number}`                  | Up to `limit` (default 20) nodes whose label contains `q` (case-insensitive). Each entry includes `id`, `label`, `source_file`, `source_location`. |
| `neighbors`      | `{id: string}`                                 | `{outgoing: [{target, relation, confidence}…], incoming: […]}` for the given node id |
| `query_node`     | `{id: string}`                                 | Full metadata for a single node                                         |
| `shortest_path`  | `{from: string, to: string}`                   | Array of node ids forming a shortest undirected path (empty if disconnected) |

Node ids are `<source_file>::<symbol_name>` (for example `crates/graphy-core/src/cluster.rs::cluster`). Imports use `extern::<imported-path>`.

Confidence labels on edges:

- `EXTRACTED` — explicitly stated in the source (an `import`, a `#include`, …)
- `INFERRED` — second-pass call-graph match (the callee's leaf name matches a defined symbol in the workspace)
- `AMBIGUOUS` — flagged for human review

## Workflow

1. **Stats first.** Call `stats` once at the start of any investigation so you know the graph's shape. If `nodes` is `0`, the background build has not finished yet — run `graphy .` in the workspace or wait a moment and call `stats` again. The SessionStart hook kicks off the build automatically.
2. **Search by label** before reading files. `search_label` is faster than `Grep` and avoids matches in comments / strings / partial identifiers.
3. **Pivot via neighbors** once you have a node id. The incoming edges tell you who depends on it; outgoing edges tell you what it depends on.
4. **shortest_path** is the right move for "how does feature X reach module Y" style questions.
5. **Confirm with a Read** only when you need source text or to verify a non-trivial claim. The graph tells you _where_ to read; it does not replace reading entirely.

## Caveats

- Generated code that is not part of the on-disk tree (procedural macro output, codegen build steps) is invisible to graphy.
- Dynamic dispatch (trait objects, function pointers, JIT'd code) is not captured — only direct call expressions.
- `INFERRED` call edges resolve by leaf name; two different `helper` functions in different modules collide. Use `source_file` on the resolved node to disambiguate.
- The auto-build hook skips rebuilds while a build is already in flight, so the very first MCP call in a fresh workspace may return zero nodes for a few seconds. Re-run after the lock file clears.
