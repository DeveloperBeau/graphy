# ChaCha20

A stream cipher measured nightly on the full fleet; this chapter links
its [parameters](chacha20-parameters.md) and [results](chacha20-results.md).

## ChaCha20 in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
stream cipher in the [cipher index](cipher-index.md).

## ChaCha20 implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[XChaCha20](xchacha20.md).
