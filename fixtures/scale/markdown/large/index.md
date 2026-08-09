# cipherbench handbook

cipherbench runs a fixed workload against every cipher built into the
harness and records throughput, latency and memory figures into a
results store for later comparison.

## Reading order

[How runs work](methodology.md) explains the measurement rules, and
[the results store](results-store.md) covers the output format. The
machine list lives in [hardware notes](hardware.md), and day-to-day
operation in [running the harness](running.md).

## Cipher chapters

Each cipher in the suite has a chapter, beginning with [AES](aes.md)
and [ChaCha20](chacha20.md); the full list sits in the
[cipher index](cipher-index.md).

Interpretation guides: [throughput](throughput.md),
[latency](latency.md) and [memory use](memory-use.md).
