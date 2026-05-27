# Benchmarks

`bench/compare.sh` is the release perf harness. It runs every fixture under `fixtures/` three times each (configurable), records best-of-N wall time and worst-of-N peak RSS, and writes a markdown summary to `bench/comparison.md`.

```bash
bash bench/compare.sh fixtures bench/comparison.md 3
```

## Opt-in assertion gates

- `BENCH_ASSERT=1` — fails the bench run if any fixture's warm `dedup_imports_resolved` exceeds 20 % of its cold count (i.e. the post-dedup cache is not delivering at least an 80 % reduction).
- `BENCH_ASSERT_SCC=1` — fails the bench run if any fixture's SCC-on warm wall time exceeds 1.10× the SCC-off warm wall time. Manual / opt-in (timing-sensitive on busy machines).

## Headline numbers

Best-of-five wall time on a 54-file mixed-language fixture (rust + python + ts + go):

| Mode                  | Wall time | Peak RSS |
|-----------------------|----------:|---------:|
| Static built-ins      |     7 ms  |   10 MB  |
| Lazy dylib plugins    |    20 ms  |   14 MB  |
| Warm cache (any path) |     3 ms  |    9 MB  |

Single-file fixtures land in 2–4 ms cold. Cache hits flatten to 3 ms regardless of language.
