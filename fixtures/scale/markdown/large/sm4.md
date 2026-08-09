# SM4

A block cipher measured nightly on the full fleet; this chapter links
its [parameters](sm4-parameters.md) and [results](sm4-results.md).

## SM4 in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
block cipher in the [cipher index](cipher-index.md).

## SM4 implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[SEED](seed.md).
