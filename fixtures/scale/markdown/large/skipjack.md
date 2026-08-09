# Skipjack

A block cipher measured nightly on the full fleet; this chapter links
its [parameters](skipjack-parameters.md) and [results](skipjack-results.md).

## Skipjack in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
block cipher in the [cipher index](cipher-index.md).

## Skipjack implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[GOST](gost.md).
