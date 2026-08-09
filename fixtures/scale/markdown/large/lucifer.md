# Lucifer

A block cipher measured nightly on the full fleet; this chapter links
its [parameters](lucifer-parameters.md) and [results](lucifer-results.md).

## Lucifer in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
block cipher in the [cipher index](cipher-index.md).

## Lucifer implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[3-Way](threeway.md).
