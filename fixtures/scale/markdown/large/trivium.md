# Trivium

A stream cipher measured nightly on the full fleet; this chapter links
its [parameters](trivium-parameters.md) and [results](trivium-results.md).

## Trivium in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
stream cipher in the [cipher index](cipher-index.md).

## Trivium implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[MICKEY](mickey2.md).
