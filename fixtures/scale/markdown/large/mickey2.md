# MICKEY

A stream cipher measured nightly on the full fleet; this chapter links
its [parameters](mickey2-parameters.md) and [results](mickey2-results.md).

## MICKEY in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
stream cipher in the [cipher index](cipher-index.md).

## MICKEY implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[SNOW 3G](snow3g.md).
