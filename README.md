# graphy

standalone implementation that turns a folder of code into a queryable knowledge graph, fast.

```
cargo run --release -- .
```

Writes the same tri-output bundle as graphy so existing tooling can consume it unchanged:

```
graphy-out/
├── graph.json       full nodes + edges
├── GRAPH_REPORT.md  god nodes, community count, ambiguous-edge highlights
└── graph.html       v0 placeholder viewer
```

## Benchmark vs graphy (best of 3, macOS, M-series)

| fixture             | graphy (ms) | graphy (ms) | speedup | graphy RSS | graphy RSS |
|---------------------|------------:|--------------:|--------:|-----------:|-------------:|
| go-mini-service     |          23 |           131 |   5.7×  |     5.3 MB |      43.1 MB |
| python-mini-cli     |          23 |           136 |   5.9×  |     5.4 MB |      43.3 MB |
| rust-mini-webserver |          23 |           130 |   5.7×  |     5.6 MB |      43.6 MB |
| ts-mini-api         |          23 |           129 |   5.6×  |     5.9 MB |      43.8 MB |
| medium-multilang    |          26 |           315 |  12.1×  |     8.7 MB |      47.0 MB |

That's **~6× faster** on tiny inputs (where Python startup dominates), **~12× faster** as the workload grows, and **~8× less peak memory** across the board. Generate the table yourself:

```
bench/compare.sh
```

The harness installs `graphy` from PyPI (`uv tool install graphy`) if it's not already on PATH, runs both engines on every fixture, and emits `bench/comparison.md`.

## Pipeline mapping (v8 → graphy)

| graphy         | graphy (Rust)                 | Notes |
|---------------------------|-------------------------------|-------|
| `detect.collect_files`    | `detect::collect_files`       | `ignore` crate, gitignore-aware, `graphy-out/` self-exclusion |
| `extract.extract`         | `extract::extract`            | tree-sitter, parallel via rayon |
| `build.build_graph`       | `build::build_graph`          | petgraph `DiGraph` |
| `cluster.cluster`         | `cluster::cluster`            | **Louvain modularity** (multi-pass folding) |
| `analyze.analyze`         | `analyze::analyze`            | god nodes by degree, ambiguous-edge counter |
| `report.render_report`    | `report::render`              | Markdown |
| `export.export`           | `export::export`              | writes `graphy-out/` |
| `cache.*`                 | `cache::partition`            | stub |
| `security.*`              | `security::*`                 | label sanitization + symlink-aware path validation |
| `validate.validate_extraction` | `validate::validate`     | schema check |

## Language coverage

37 languages ship in v0.1:

| Language       | Suffix(es)                                           |
|----------------|------------------------------------------------------|
| Rust           | `.rs`                                                |
| Python         | `.py`                                                |
| JavaScript     | `.js`, `.jsx`, `.mjs`, `.cjs`, `.ejs`                |
| TypeScript     | `.ts`, `.tsx`                                        |
| Go             | `.go`                                                |
| Java           | `.java`                                              |
| C              | `.c`, `.h`                                           |
| C++            | `.cpp`, `.cc`, `.cxx`, `.hpp`                        |
| Ruby           | `.rb`                                                |
| C#             | `.cs`                                                |
| Bash           | `.sh`, `.bash`                                       |
| JSON           | `.json`                                              |
| Swift          | `.swift`                                             |
| Kotlin         | `.kt`, `.kts`                                        |
| PHP            | `.php`                                               |
| Scala          | `.scala`, `.sc`                                      |
| Lua            | `.lua`, `.luau`                                      |
| Zig            | `.zig`                                               |
| Elixir         | `.ex`, `.exs`                                        |
| Objective-C    | `.m`, `.mm`                                          |
| Julia          | `.jl`                                                |
| HTML           | `.html`, `.htm`                                      |
| CSS            | `.css`                                               |
| Groovy/Gradle  | `.groovy`, `.gradle`                                 |
| PowerShell     | `.ps1`                                               |
| Verilog        | `.v`, `.sv`                                          |
| Fortran        | `.f`, `.f90`, `.f95`, `.f03`, `.f08`, `.for`         |
| SQL            | `.sql`                                               |
| R              | `.r`                                                 |
| Dart           | `.dart`                                              |
| Svelte         | `.svelte`                                            |
| Markdown       | `.md`, `.mdx`, `.qmd`                                |
| YAML           | `.yaml`, `.yml`                                      |
| Pascal/Delphi  | `.pas`, `.pp`, `.dpr`, `.dpk`, `.lpr`, `.inc`        |
| Perl           | `.pl`, `.pm`, `.t`                                   |
| Haskell        | `.hs`                                                |
| OCaml          | `.ml`, `.mli`                                        |
| Erlang         | `.erl`, `.hrl`                                       |
| TOML           | `.toml`                                              |

Each extractor emits nodes for top-level definitions (functions / classes / structs / interfaces / records / etc.), edges for imports (`use` / `import` / `require` / `#include` / `@import`), and call-graph edges (`Confidence::Inferred`) for direct invocations resolvable to a local symbol.

## Modes

```
graphy <path>                      # one-shot run (default)
graphy run <path>                  # same, explicit
graphy watch <path>                # rebuild on every change (notify + debounce)
graphy serve --graph graph.json    # MCP-style JSON-RPC server over stdio
graphy doctor                      # version + arch
```

### Cache

Each run writes `graphy-out/.cache/manifest.json` mapping every input file to its blake3 content hash, and stores the per-file `ExtractionOutput` JSON beside it. On the next run, files whose hash hasn't changed are served from cache (medium-multilang fixture: cold 14 ms → warm 4 ms, ~3.5× speedup).

### Watch

`graphy watch <path>` runs the initial build, then re-runs whenever a tracked file changes. Uses `notify` + a 250 ms debouncer; ignores changes inside `graphy-out/`. Combine with `--out` to write the bundle elsewhere.

### Interactive viewer

`graphy-out/graph.html` is a self-contained interactive viewer: pan, zoom, click a node to highlight its neighbors, filter by label, community-colored. Pure inline JS + SVG — no external CDN, opens offline.

### MCP serve

`graphy serve --graph graph.json` reads JSON-RPC requests from stdin and writes responses to stdout. Supports `initialize`, `tools/list`, and `tools/call` with five tools:

| Tool             | Returns                                                        |
|------------------|----------------------------------------------------------------|
| `stats`          | total nodes, edges, communities                                |
| `search_label`   | substring matches over node labels                             |
| `neighbors`      | outgoing + incoming edges for a node id                        |
| `query_node`     | full metadata for a node id                                    |
| `shortest_path`  | undirected BFS shortest path between two node ids              |

## Layout

```
graphy/
├── Cargo.toml                       # workspace
├── crates/
│   ├── graphy-core/                 # library
│   │   ├── src/
│   │   │   ├── detect.rs            # collect_files (gitignore-aware)
│   │   │   ├── extract/             # per-language extractors
│   │   │   │   ├── mod.rs           # dispatch by suffix
│   │   │   │   ├── common.rs        # shared emit helpers
│   │   │   │   ├── rust.rs python.rs js_ts.rs go.rs
│   │   │   │   ├── java.rs c_family.rs ruby.rs csharp.rs
│   │   │   │   ├── bash.rs json.rs
│   │   │   ├── build.rs             # extraction → petgraph
│   │   │   ├── cluster.rs           # Louvain modularity
│   │   │   ├── analyze.rs           # god nodes, ambiguous edges
│   │   │   ├── report.rs            # GRAPH_REPORT.md
│   │   │   ├── export.rs            # graphy-out/{graph.json,html,md}
│   │   │   ├── cache.rs             # file-hash cache (stub)
│   │   │   ├── security.rs          # input validation
│   │   │   ├── validate.rs          # extractor schema check
│   │   │   ├── schema.rs            # Node / Edge / Confidence
│   │   │   ├── graph.rs             # KnowledgeGraph wrapper
│   │   │   └── pipeline.rs          # orchestrator
│   │   └── tests/                   # one integration-test file per module
│   └── graphy-cli/                  # binary `graphy`
├── fixtures/                        # synthesized sample projects
│   ├── go-mini-service/
│   ├── python-mini-cli/
│   ├── rust-mini-webserver/
│   ├── ts-mini-api/
│   ├── medium-multilang/            # 56-file mixed-language fixture
│   └── gen-medium.sh                # deterministic fixture generator
└── bench/
    └── compare.sh                   # head-to-head harness vs Python graphy
```

## Tests

224 tests, 94.42% line coverage, 91.22% region coverage across `graphy-core` + `graphy-cli`. Each module gets a dedicated test file covering:

- **Success paths** — normal inputs produce the expected nodes / edges.
- **Edge cases** — empty input, single-element input, mixed Unicode, large files, deeply nested syntax.
- **Failure paths** — missing files, malformed source, non-UTF-8 bytes, invalid JSON.
- **Hostile / hacking cases** — XSS in labels, null-byte injection, ANSI escapes, RTL override, oversized labels, path traversal (`..`), symlink escapes, gitignore bypass, target-as-directory writes, read-only output dirs.

```
cargo test
cargo llvm-cov --package graphy-core --summary-only
```

## License

MIT.
