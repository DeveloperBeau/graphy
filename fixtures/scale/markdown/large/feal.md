# FEAL

A block cipher measured nightly on the full fleet; this chapter links
its [parameters](feal-parameters.md) and [results](feal-results.md).

## FEAL in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
block cipher in the [cipher index](cipher-index.md).

## FEAL implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[Lucifer](lucifer.md).
