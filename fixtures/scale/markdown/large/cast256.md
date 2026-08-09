# CAST-256

A block cipher measured nightly on the full fleet; this chapter links
its [parameters](cast256-parameters.md) and [results](cast256-results.md).

## CAST-256 in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
block cipher in the [cipher index](cipher-index.md).

## CAST-256 implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[IDEA](idea.md).
