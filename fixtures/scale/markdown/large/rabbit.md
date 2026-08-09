# Rabbit

A stream cipher measured nightly on the full fleet; this chapter links
its [parameters](rabbit-parameters.md) and [results](rabbit-results.md).

## Rabbit in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
stream cipher in the [cipher index](cipher-index.md).

## Rabbit implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[HC-128](hc128.md).
