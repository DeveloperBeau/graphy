# RC6

A block cipher measured nightly on the full fleet; this chapter links
its [parameters](rc6-parameters.md) and [results](rc6-results.md).

## RC6 in the suite

The harness uses a portable reference implementation, measured under
the rules in [how runs work](methodology.md). It is registered as a
block cipher in the [cipher index](cipher-index.md).

## RC6 implementation notes

The reference code favours clarity over speed; platform-specific
variants are out of scope. A frequent comparison point is
[TEA](tea.md).
