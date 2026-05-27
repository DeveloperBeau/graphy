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

## Install

```bash
# Release tarball
curl -fsSL <release-url>/install.sh | sh

# Or from source
cargo install --path crates/graphy-cli
```

Verify with `graphy doctor && graphy plugins list`. Full install / packaging notes in [docs/install.md](docs/install.md).

## Integrations

Editor- and agent-level wrappers around the `graphy` CLI and its MCP server. Each integration has a self-contained guide.

| Integration | Status | Doc |
|-------------|--------|-----|
| Claude Code | v1 (stable) | [integrations/claude-code.md](integrations/claude-code.md) |

See [`integrations/`](integrations/) for the contributor skeleton and future additions.

## Headline numbers

Best-of-five wall time on a 54-file mixed-language fixture (rust + python + ts + go):

| Mode                  | Wall time | Peak RSS |
|-----------------------|----------:|---------:|
| Static built-ins      |     7 ms  |   10 MB  |
| Lazy dylib plugins    |    20 ms  |   14 MB  |
| Warm cache (any path) |     3 ms  |    9 MB  |

Single-file fixtures land in 2–4 ms cold. Cache hits flatten to 3 ms regardless of language.

## Languages

37 languages ship as plugins: Rust, Python, JavaScript, TypeScript, Go, Java, C, C++, Ruby, C#, Bash, JSON, Swift, Kotlin, PHP, Scala, Lua, Zig, Elixir, Objective-C, Julia, HTML, CSS, Groovy/Gradle, PowerShell, Verilog, Fortran, SQL, R, Dart, Svelte, Markdown, YAML, Pascal/Delphi, Perl, Haskell, OCaml, Erlang, TOML.

Full extension table, node kinds, edge relations, and format-specific extraction details: [docs/language-coverage.md](docs/language-coverage.md).

## Docs

Detailed reference lives under [`docs/`](docs/):

| Topic | Doc |
|-------|-----|
| Pipeline stages, repository layout, output bundle | [architecture.md](docs/architecture.md) |
| CLI modes (`run` / `watch` / `serve` / `plugins` / `doctor`) | [modes.md](docs/modes.md) |
| Content-hash, post-dedup, SCC, hierarchical Louvain caches | [caching.md](docs/caching.md) |
| Plugin architecture, manifest, discovery, C ABI | [plugins.md](docs/plugins.md) |
| Language coverage tables and edge semantics | [language-coverage.md](docs/language-coverage.md) |
| `stats.json` fields and `GRAPH_REPORT.md` shape | [analysis.md](docs/analysis.md) |
| `bench/compare.sh`, assertion gates | [benchmarks.md](docs/benchmarks.md) |
| Test layout and language-coverage harness | [testing.md](docs/testing.md) |
| Build from source, release packaging | [install.md](docs/install.md) |

## License

MIT.
