# SEAL

A stream cipher measured nightly on the full fleet; this chapter links
its [parameters](seal-parameters.md) and [results](seal-results.md).

## SEAL in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
stream cipher in the [cipher index](cipher-index.md).

## SEAL implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[Panama](panama.md).
