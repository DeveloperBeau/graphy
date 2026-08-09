# RC5

A block cipher measured nightly on the full fleet; this chapter links
its [parameters](rc5-parameters.md) and [results](rc5-results.md).

## RC5 in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
block cipher in the [cipher index](cipher-index.md).

## RC5 implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[RC6](rc6.md).
