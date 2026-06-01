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

On **macOS / Linux**, download the latest release and add it to your PATH:

```bash
curl -fsSL https://raw.githubusercontent.com/DeveloperBeau/graphy/main/install.sh | sh
```

**Windows** (PowerShell):

```powershell
irm https://raw.githubusercontent.com/DeveloperBeau/graphy/main/install.ps1 | iex
```

**From source** (any platform with a Rust toolchain):

```bash
cargo install --path crates/graphy-cli
```

Verify with `graphy doctor && graphy plugins list`. You should see a version line and 37 language plugins. Full install and packaging notes in [docs/install.md](docs/install.md).

Prebuilt releases cover macOS (Apple Silicon + Intel), Linux x86_64, and Windows x86_64. Other targets: build from source.

To remove it (deletes `~/.graphy` and the PATH line the installer added):

```bash
curl -fsSL https://raw.githubusercontent.com/DeveloperBeau/graphy/main/uninstall.sh | sh   # macOS / Linux
irm https://raw.githubusercontent.com/DeveloperBeau/graphy/main/uninstall.ps1 | iex         # Windows
```

## Use with Claude Code

Install the `graphy` binary (above), then add the plugin from Claude Code with two commands:

```
/plugin marketplace add DeveloperBeau/graphy
/plugin install graphy@graphy
```

Choose **user** scope when prompted to make it available in every project. The plugin auto-builds a graph the first time Claude reads a file, then exposes MCP tools (`search_label`, `neighbors`, `query_node`, `shortest_path`, `stats`) so Claude queries the graph instead of grepping.

> The plugin runs the `graphy` binary on disk, so install it first. On **Windows** the plugin's hooks and MCP server run as `sh` scripts: install [Git for Windows](https://gitforwindows.org/) or run Claude Code under WSL. The standalone CLI works natively.

To steer Claude toward it, add this to your project's `CLAUDE.md`:

```markdown
## Code navigation
A graphy knowledge graph of this repo is available via MCP. Prefer it over grep/file-reading
to locate symbols, callers, and dependencies: use `search_label` to find a symbol, `neighbors`
to see callers/callees, `shortest_path` to trace connections, and `stats` for an overview.
Read files only to confirm details once the graph has pointed you to the right place.
```

Full setup, slash commands, and troubleshooting: [integrations/claude-code.md](integrations/claude-code.md).

## Other integrations

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
