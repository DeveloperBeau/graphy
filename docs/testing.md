# Tests

600+ integration tests covering every pipeline stage, both extractor and plugin paths, plus hostile-input cases (XSS in labels, NUL injection, ANSI escapes, RTL override, oversized labels, path traversal, symlink escape, sha256-mismatched plugins, gigantic files, deep nesting, malformed source, gitignore bypass, target-as-directory writes, read-only output dirs).

```bash
cargo test
cargo llvm-cov --summary-only
```

## Per-language coverage harness

Each shipped language has a dedicated integration binary at `crates/graphy-core/tests/lang_<lang>.rs` and a multi-file fixture at `fixtures/lang-coverage/<lang>/`. Tests run in two tiers per language:

- **Tier 1 (per-file extract)** — `extract(path)` on each fixture file, asserting every checklist node `kind` and edge `relation` the extractor claims to emit.
- **Tier 2 (full pipeline)** — `Pipeline::new(cfg).run()` on the fixture root with hermetic `tempdir` output, asserting cross-file imports resolve through dedup, external calls produce no local edge, inheritance / implements / contains edges survive resolution, and a node-count floor guards against silent regressions.

Shared helpers live in `crates/graphy-core/tests/lang_coverage/common.rs` (`fixture_dir`, `extract_file`, `assert_extract_has`, `assert_extract_edge`, `run_pipeline`, `assert_node`, `assert_edge`, `assert_no_edge`).

## Scale harness (small / medium / large real projects per language)

`fixtures/scale/<lang>/{small,medium,large}/` holds a real, buildable project per language at each size — small (~12 files), medium (~50 files), large (~200 files) — plus an `expected.json` ground-truth file stating specific facts about the graph (a node count floor, specific `(label, kind)` nodes, specific `(source, relation, target)` edges by id suffix) derived from and verified against the actual extractor output.

To keep the graphs comparable across all 39 languages, every project builds the same three tools: small is a text printer CLI (input parsing, alignment, borders, styles), medium is an expression calculator (lexer, parser, evaluator, function library, history), and large is an encryption testing tool (one module per cipher/hash family in a model/impl/runner pattern, a benchmark runner, a file-backed results store persisting between sessions, and live progress output). External libraries are used where a language's standard library has no crypto/math support, the way a real project would.

`crates/graphy-core/tests/fixture_scale.rs` runs the full pipeline over every project and asserts:

- the pipeline succeeds and the node-count floor from `expected.json` is met,
- every expected node (`label` + `kind`) and every expected edge (matched by id suffix on source/target, exact `relation`) is present in the actual graph,
- **no node is isolated** — holds for every language, including data/markup formats (sections, keys, headings anchor to their file via `contains`),
- node counts grow strictly small < medium < large per language.

Because expectations are specific facts checked against real output rather than just a floor, the harness verifies the extractor got the *right* answer for real code shapes, not merely that it produced *some* graph.

Per-language capability audits with feature checklists, supported-vs-deferred tables, and commit references for closed gaps are tracked outside this repo.
