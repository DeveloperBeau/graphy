# Architecture

## Pipeline

```
detect → extract → build → cluster → analyze → report → export
```

Each stage is a single function. Communication is plain Rust structs; no shared mutable state outside `graphy-out/`.

| Stage    | Purpose                                                                  |
|----------|--------------------------------------------------------------------------|
| detect   | Walk filesystem, respect `.gitignore`, filter by extension               |
| extract  | tree-sitter parse + emit nodes/edges per file (parallel via rayon)       |
| build    | Merge per-file extractions into one petgraph `DiGraph`                   |
| cluster  | Louvain modularity-maximizing community detection                        |
| analyze  | God nodes by degree, ambiguous-edge count, community totals              |
| report   | `GRAPH_REPORT.md`                                                        |
| export   | `graph.json` + interactive `graph.html` viewer                           |

## Repository layout

```
graphy/
├── Cargo.toml                       # workspace
├── crates/
│   ├── graphy-core/                 # pipeline + lazy loader + manifest
│   ├── graphy-cli/                  # binary
│   ├── graphy-plugin-api/           # C ABI + define_plugin! macro + helpers
│   └── plugins/
│       └── graphy-plugin-*/         # 37 language cdylib crates
├── claude-plugin/                   # Claude Code integration plugin
├── integrations/                    # per-host integration guides
├── docs/                            # this folder
├── fixtures/                        # synthesized sample projects + lang-coverage fixtures
├── bench/compare.sh                 # release perf harness
├── tools/package-release.sh         # build + tarball release
└── install.sh                       # curl-able installer
```

## Output bundle

Every run writes a tri-output bundle to `graphy-out/` (or wherever `--out` points):

```
graphy-out/
├── graph.json       full nodes + edges (machine-readable)
├── GRAPH_REPORT.md  god nodes, community count, ambiguous-edge highlights
├── graph.html       interactive viewer (pan/zoom, click-to-highlight neighbors)
└── stats.json       analysis counters (see analysis.md)
```

`graph.html` is a self-contained interactive viewer: pan, zoom, click a node to highlight neighbors, label search, community-colored. Pure inline JS + SVG — no external CDN, opens offline.
