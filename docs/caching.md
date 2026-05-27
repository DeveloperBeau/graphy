# Caching & incremental rebuild

graphy keeps four layers of cache state under `graphy-out/.cache/`. Each is independently invalidated and can be disabled via a CLI flag for diagnosis.

## Content-hash cache

Each run writes `graphy-out/.cache/manifest.json` mapping every input file to its blake3 content hash and stores per-file `ExtractionOutput` JSON beside it. On the next run, files whose hash is unchanged are served from cache and tree-sitter is skipped.

Cold → warm: typically 3–5× speedup; identical graph shape.

## Post-dedup cache

Each cached extraction is paired with a small `<hash>.dedup.json` file under `graphy-out/.cache/`. The file records the canonical-id redirects produced by the prior dedup pass so warm incremental runs apply them at splice time instead of re-resolving every cross-file import.

Schema version is tracked via the cache manifest's `abi_version` field; older v1 caches are accepted and upgraded in-place on the first new run.

Disable with `--no-dedup` if you need to debug dedup behavior (rare).

## Cycle-aware delta-Louvain (SCC expansion)

Strongly-connected components (e.g. recursive call cycles, mutually recursive types) are detected on the first run and cached at `graphy-out/.cache/scc.json`. Incremental runs widen delta-Louvain's hot frontier to cover every node in any cycle touching a dirty node, so community labels propagate fully through the cycle. The SCC index is patched in place when edges change.

Use `--no-scc-expansion` to disable.

## Hierarchical clustering

Louvain's hierarchical fold state is persisted to `graphy-out/.cache/louvain-levels.json` after every clustering pass. On warm incremental runs, the prior levels seed the new pass: only the super-nodes that the dirty set touches get re-evaluated, leaving unrelated community structure untouched.

A quality gate guards the fast path: if the delta pass produces a modularity drop greater than 5 % relative and 0.02 absolute, the algorithm falls back to a fresh full Louvain pass and refreshes the cache.

Use `--no-hierarchical` to disable the level cache entirely (falls back to single-pass constrained moving with SCC expansion).

## Force a full rebuild

Pass `--full` to ignore every cache and rebuild from scratch. Use this when you suspect a cache is poisoned or want to compare cold vs warm timings.

## What invalidates each cache

| Cache                | Invalidated by                                                                   |
|----------------------|----------------------------------------------------------------------------------|
| Content hash         | File content changes (blake3 of source bytes)                                    |
| Post-dedup redirects | Any cross-file import target appearing / disappearing / renamed                  |
| SCC index            | Any edge whose source or target is in a known cycle                              |
| Hierarchical levels  | Modularity drop > 5 % relative or > 0.02 absolute, OR `--no-hierarchical` set    |
