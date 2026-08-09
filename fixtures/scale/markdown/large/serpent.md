# Serpent

A block cipher measured nightly on the full fleet; this chapter links
its [parameters](serpent-parameters.md) and [results](serpent-results.md).

## Serpent in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
block cipher in the [cipher index](cipher-index.md).

## Serpent implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[Twofish](twofish.md).
