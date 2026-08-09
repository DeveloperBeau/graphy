# Salsa20

A stream cipher measured nightly on the full fleet; this chapter links
its [parameters](salsa20-parameters.md) and [results](salsa20-results.md).

## Salsa20 in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
stream cipher in the [cipher index](cipher-index.md).

## Salsa20 implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[Sosemanuk](sosemanuk.md).
