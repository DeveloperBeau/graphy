# The results store

Results land in a single SQLite file, one row per pass, keyed by run,
cipher and machine. Nothing is ever overwritten; re-runs append.

## Schema sketch

The row layout is deliberately flat: identifiers, the three headline
figures, and the spread columns. The headline figures are the ones
interpreted in [throughput](throughput.md), [latency](latency.md) and
[memory use](memory-use.md).

## Exporting

`cipherbench export --run last` writes CSV to stdout. The columns match
the store one for one, so spreadsheets and the guides in this handbook
use the same names, as introduced in [how runs work](methodology.md).
