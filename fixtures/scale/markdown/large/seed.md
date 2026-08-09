# SEED

A block cipher measured nightly on the full fleet; this chapter links
its [parameters](seed-parameters.md) and [results](seed-results.md).

## SEED in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
block cipher in the [cipher index](cipher-index.md).

## SEED implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[CAST5](cast5.md).
