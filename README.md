# graphy

Turn a folder of code into a queryable knowledge graph. Fast, plugin-driven, ships as a single binary.

```bash
graphy .
```

Writes a tri-output bundle to `graphy-out/`:

```
graphy-out/
├── graph.json       full nodes + edges (machine-readable)
├── GRAPH_REPORT.md  god nodes, community count, ambiguous-edge highlights
└── graph.html       interactive viewer (pan/zoom, click-to-highlight neighbors)
```

## Headline numbers

Best-of-five wall time on a 54-file mixed-language fixture (rust + python + ts + go):

| mode                  | wall time | peak RSS |
|-----------------------|----------:|---------:|
| static built-ins      |     7 ms  |   10 MB  |
| lazy dylib plugins    |    20 ms  |   14 MB  |
| warm cache (any path) |     3 ms  |    9 MB  |

Single-file fixtures land in 2–4 ms cold. Cache hits flatten to 3 ms regardless of language.

## Pipeline

```
detect → extract → build → cluster → analyze → report → export
```

Each stage is a single function. Communication is plain Rust structs; no shared mutable state outside `graphy-out/`.

| stage    | purpose                                                                  |
|----------|--------------------------------------------------------------------------|
| detect   | walk filesystem, respect `.gitignore`, filter by extension               |
| extract  | tree-sitter parse + emit nodes/edges per file (parallel via rayon)       |
| build    | merge per-file extractions into one petgraph `DiGraph`                   |
| cluster  | Louvain modularity-maximizing community detection                        |
| analyze  | god nodes by degree, ambiguous-edge count, community totals              |
| report   | GRAPH_REPORT.md                                                          |
| export   | `graph.json` + interactive `graph.html` viewer                           |

## Modes

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

### Cache

Each run writes `graphy-out/.cache/manifest.json` mapping every input file to its blake3 content hash and stores per-file `ExtractionOutput` JSON beside it. On the next run files whose hash is unchanged are served from cache and tree-sitter is skipped. Cold → warm: typical 3–5× speedup; identical graph shape.

### Post-dedup cache

Each cached extraction is paired with a small `<hash>.dedup.json`
file under `graphy-out/.cache/`. The file records the canonical-id
redirects produced by the prior dedup pass so warm incremental runs
apply them at splice time instead of re-resolving every cross-file
import. Schema version is tracked via the cache manifest's
`abi_version` field; older v1 caches are accepted and upgraded
in-place on the first new run.

### Cycle-aware delta-Louvain

Strongly-connected components (e.g. recursive call cycles, mutually
recursive types) are detected on the first run and cached at
`graphy-out/.cache/scc.json`. Incremental runs widen delta-Louvain's
hot frontier to cover every node in any cycle touching a dirty node, so
community labels propagate fully through the cycle. The SCC index is
patched in place when edges change. Use `--no-scc-expansion` to disable.

### Hierarchical clustering

Louvain's hierarchical fold state is persisted to
`graphy-out/.cache/louvain-levels.json` after every clustering pass.
On warm incremental runs, the prior levels seed the new pass: only the
super-nodes that the dirty set touches get re-evaluated, leaving
unrelated community structure untouched.

A quality gate guards the fast path: if the delta pass produces a
modularity drop greater than 5 % relative and 0.02 absolute, the
algorithm falls back to a fresh full Louvain pass and refreshes the
cache.

Use `--no-hierarchical` to disable the level cache entirely (falls
back to single-pass constrained moving with SCC expansion).

### Watch

`graphy watch <path>` runs the initial build then re-runs whenever a tracked file changes. Uses `notify` + a 250 ms debouncer; changes inside `graphy-out/` are ignored to avoid feedback loops.

### Interactive viewer

`graphy-out/graph.html` is a self-contained interactive viewer: pan, zoom, click a node to highlight neighbors, label search, community-colored. Pure inline JS + SVG — no external CDN, opens offline.

### MCP serve

`graphy serve --graph graph.json` reads JSON-RPC over stdin/stdout. Methods: `initialize`, `tools/list`, `tools/call`. Tools: `stats`, `search_label`, `neighbors`, `query_node`, `shortest_path`.

## Plugin architecture

Languages ship as separate dynamic libraries. The core binary stays slim; per-language `cdylib` plugins are bundled in `plugins/` alongside the binary in release packages and lazy-loaded only on first encounter of a matching file extension.

### Manifest

`plugins/manifest.toml` enumerates every shipped plugin:

```toml
abi_version = 1

[[plugin]]
name = "graphy-plugin-rust"
version = "0.1.0"
file = "libgraphy_plugin_rust.dylib"
extensions = ["rs"]
sha256 = "..."
```

At startup graphy reads the manifest (cheap) and builds an `extension → plugin` index. The first time it encounters a matching file it `dlopen`s the dylib, verifies the recorded sha256, and caches the loaded handle. Subsequent files of the same language reuse the loaded library.

### Plugin discovery (priority order)

1. `$GRAPHY_PLUGIN_PATH` (colon-separated)
2. `$XDG_DATA_HOME/graphy/plugins/` (macOS: `~/Library/Application Support/graphy/plugins/`)
3. `./graphy-plugins/`
4. `<exe-dir>/plugins/`

### Plugin ABI

`graphy-plugin-api` defines the host/plugin contract via four C-ABI symbols:

```c
extern uint32_t graphy_plugin_abi_version(void);
extern const GraphyPluginMetadata *graphy_plugin_metadata(void);
extern GraphyPluginExtractResult graphy_plugin_extract(
    const char *path_utf8, size_t path_len,
    const uint8_t *src, size_t src_len);
extern void graphy_plugin_free(GraphyPluginExtractResult);
```

JSON is the boundary payload so plugins keep their own internal types. The `define_plugin!` macro generates every symbol from a single declarative call; per-plugin `lib.rs` is around 10 lines of boilerplate plus the tree-sitter walk.

## Language coverage

37 languages ship as plugins:

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

### Node kinds

Each plugin emits nodes for top-level definitions of its language:

| Kind             | Languages where supported                                          |
|------------------|--------------------------------------------------------------------|
| `function`       | every language with named functions / methods / subroutines        |
| `class`          | OO languages (Python, Java, Kotlin, Swift, C#, C++, Ruby, ...)     |
| `struct`         | Rust, Swift, C, C++, Go, Zig, Julia                                |
| `enum`           | Rust, Swift, C, C++, Java, Kotlin, C#, TS, PHP, Zig                |
| `trait`          | Rust                                                               |
| `interface`      | Kotlin, Java, C#, TS, PHP, Dart, Groovy                            |
| `protocol`       | Swift, ObjC                                                        |
| `impl`           | Rust                                                               |
| `mod` / `module` | Rust, Erlang, Elixir, OCaml, Haskell, Julia, Fortran               |
| `namespace`      | C++, C#                                                            |
| `const`/`static` | Rust, Swift, Java, ...                                             |
| `type`           | Rust, OCaml, Haskell, TS (type alias), C (typedef)                 |
| `macro`          | Rust (`macro_rules!`)                                              |
| `record`         | Java, C#, Erlang                                                   |
| `mixin`          | Dart                                                               |
| `import`         | every language with module-level imports                           |
| `pair` / `key`   | TOML (key in section), JSON/YAML keys                              |

### Edge relations

Five edge relations are emitted, per-language as applicable:

| Relation     | Meaning                                                              |
|--------------|----------------------------------------------------------------------|
| `imports`    | `use` / `import` / `require` / `#include` / `@import`                |
| `calls`      | Direct invocations resolving to a local symbol (`Confidence::Inferred`) |
| `inherits`   | `class A: B` / `extends` / `: BaseClass` / Haskell `class ... where` |
| `implements` | `impl Trait for Type` / `implements I` / `: IFoo` (C#) / ObjC `<P>`  |
| `contains`   | Parent-child structural (mod → fn, impl → method, class → method)    |
| `references` | Type usage in function signatures (parameters + return types)        |

After deduplication the pipeline collapses `extern::<Name>` stubs onto canonical local definitions, so cross-file `imports`/`implements`/`references` resolve to the real target node.

### Imports

Braced and glob import forms are expanded into one extern node per
imported symbol so dedup can resolve each independently:

| Source                            | Externs emitted                       |
|-----------------------------------|----------------------------------------|
| `use crate::a::{helper, other};`  | `helper`, `other`                      |
| `use std::io::Result as IoResult;`| `std::io::Result`, `IoResult`          |
| `from a import x, y`              | `a.x`, `a.y`                           |
| `import { A, B } from "./m"`      | `./m/A`, `./m/B`                       |
| `import java.util.*;`             | `java.util.*` (glob preserved)         |

Aliased imports emit both the canonical path AND the alias as separate externs so either lookup resolves through dedup.

Glob imports (`a::*`, `from a import *`, `import * as ns from "..."`,
`java.util.*`) are kept intact and surface in the report as ambiguous
candidates.

### Format-specific extraction

Markup and data formats follow an adapted shape:

| Format     | Nodes                                | Edges                                        |
|------------|--------------------------------------|----------------------------------------------|
| HTML       | id-bearing elements                  | `<a href>`, `<script src>`, `<link href>`    |
| CSS        | selectors (class, id, element)       | `@import`                                    |
| SQL        | tables / views / indexes (DDL)       | `references` for inline `REFERENCES` (FK)    |
| JSON       | top-level + nested keys              | `$ref` -> referenced schema node             |
| YAML       | keys at all depths                   | `references` for `*anchor` / `<<: *anchor`   |
| TOML       | sections + per-section `pair` nodes  | -                                            |
| Markdown   | headings                             | `references` for `[text](other.md)` links    |

## Integrations

Editor- and agent-level wrappers around `graphy` and its MCP server. Each integration has a self-contained guide in [`integrations/`](integrations/):

| Integration | Status | Doc |
|-------------|--------|-----|
| Claude Code | v1 (stable) | [integrations/claude-code.md](integrations/claude-code.md) |

See [`integrations/README.md`](integrations/README.md) for the shape of each guide and how to add a new one.

## Layout

```
graphy/
├── Cargo.toml                       # workspace
├── crates/
│   ├── graphy-core/                 # pipeline + lazy loader + manifest
│   ├── graphy-cli/                  # binary
│   ├── graphy-plugin-api/           # C ABI + define_plugin! macro + helpers
│   └── plugins/
│       └── graphy-plugin-*/         # 37 language cdylib crates
├── claude-plugin/                   # Claude Code integration (see integrations/claude-code.md)
├── integrations/                    # per-host integration guides
├── fixtures/                        # synthesized sample projects + lang-coverage fixtures
├── bench/compare.sh                 # release perf harness
├── tools/package-release.sh         # build + tarball release
└── install.sh                       # curl-able installer
```

## Build / install

From source:

```bash
cargo build --release
./target/release/graphy .
```

Release bundle (binary + plugins + manifest):

```bash
bash tools/package-release.sh
# dist/graphy-<version>-<arch>-<os>.tar.gz
```

End-user install:

```bash
curl -fsSL <release-url>/install.sh | sh
```

## Analysis output

Every run writes `graphy-out/stats.json` alongside the report. Notable
fields:

- `dedup_imports_resolved` -- count of cross-file extern imports that
  the dedup pass resolved to canonical defs in this run.
- `glob_imports_skipped` -- count of `use a::*` / `from a import *`
  extern nodes left unresolved during dedup (scope analysis required).
- `modularity` -- Newman modularity of the final clustered graph.

## Benchmarks

`bench/compare.sh` is the release perf harness. It runs every fixture
under `fixtures/` three times each (configurable), records best-of-N
wall time and worst-of-N peak RSS, and writes a markdown summary to
`bench/comparison.md`.

```bash
bash bench/compare.sh fixtures bench/comparison.md 3
```

Opt-in assertion gates:

- `BENCH_ASSERT=1` -- fails the bench run if any fixture's warm
  `dedup_imports_resolved` exceeds 20% of its cold count (i.e. the
  post-dedup cache is not delivering at least an 80% reduction).
- `BENCH_ASSERT_SCC=1` -- opt-in gate that fails the bench run if any
  fixture's SCC-on warm wall time exceeds 1.10x the SCC-off warm wall
  time. Manual / opt-in (timing-sensitive on busy machines).

## Tests

600+ integration tests covering every pipeline stage, both extractor and plugin paths, plus hostile-input cases (XSS in labels, NUL injection, ANSI escapes, RTL override, oversized labels, path traversal, symlink escape, sha256-mismatched plugins, gigantic files, deep nesting, malformed source, gitignore bypass, target-as-directory writes, read-only output dirs).

```bash
cargo test
cargo llvm-cov --summary-only
```

### Per-language coverage harness

Each shipped language has a dedicated integration binary at `crates/graphy-core/tests/lang_<lang>.rs` and a multi-file fixture at `fixtures/lang-coverage/<lang>/`. Tests run in two tiers per language:

- **Tier 1 (per-file extract)** - `extract(path)` on each fixture file, asserting every checklist node `kind` and edge `relation` the extractor claims to emit.
- **Tier 2 (full pipeline)** - `Pipeline::new(cfg).run()` on the fixture root with hermetic `tempdir` output, asserting cross-file imports resolve through dedup, external calls produce no local edge, inheritance/implements/contains edges survive resolution, and a node-count floor guards against silent regressions.

Shared helpers live in `crates/graphy-core/tests/lang_coverage/common.rs` (`fixture_dir`, `extract_file`, `assert_extract_has`, `assert_extract_edge`, `run_pipeline`, `assert_node`, `assert_edge`, `assert_no_edge`).

Per-language capability audits with feature checklists, supported-vs-deferred tables, and commit references for closed gaps are tracked outside this repo.

## License

MIT.
