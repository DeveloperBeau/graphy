# How runs work

Every run pins one core, warms the cache with a discarded pass, then
measures ten passes over the same 256 MiB workload. The median pass is
reported; the spread is stored alongside it.

## What counts as a result

A pass is rejected if the machine was not idle, judged by involuntary
context switches. Rejected passes are re-run up to three times before
the cipher is marked unstable for that machine.

## Fairness rules

All ciphers use the same buffer sizes and the same measurement harness.
Implementation notes for each entry start from the
[cipher index](cipher-index.md), and the output schema is described in
[the results store](results-store.md).
