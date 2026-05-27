# Analysis output

Every run writes `graphy-out/stats.json` alongside the report. Notable fields:

| Field                       | Meaning                                                                                          |
|-----------------------------|--------------------------------------------------------------------------------------------------|
| `dedup_imports_resolved`    | Count of cross-file extern imports that the dedup pass resolved to canonical defs in this run    |
| `glob_imports_skipped`      | Count of `use a::*` / `from a import *` extern nodes left unresolved during dedup                |
| `modularity`                | Newman modularity of the final clustered graph                                                   |

The full schema lives in `graphy-core/src/analyze.rs` (`AnalysisOutput` struct).

## `GRAPH_REPORT.md`

Human-readable summary written next to `stats.json`. Surfaces:

- Top god nodes by total degree.
- Per-community totals and the largest community.
- Ambiguous-edge count (edges flagged for human review).
- Detected SCCs (cycles) and their size.

`/graphy-report` in the Claude Code integration quotes this file verbatim.
