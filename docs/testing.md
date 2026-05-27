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

Per-language capability audits with feature checklists, supported-vs-deferred tables, and commit references for closed gaps are tracked outside this repo.
