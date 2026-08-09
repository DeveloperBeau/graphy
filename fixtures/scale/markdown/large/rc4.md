# RC4

A stream cipher measured nightly on the full fleet; this chapter links
its [parameters](rc4-parameters.md) and [results](rc4-results.md).

## RC4 in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
stream cipher in the [cipher index](cipher-index.md).

## RC4 implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[ChaCha20](chacha20.md).
