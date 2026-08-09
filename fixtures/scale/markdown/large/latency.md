# Reading latency figures

Latency here means the cost of setting up a key and encrypting a single
small message: the price of the first byte, not the millionth.

## Why it diverges from throughput

Key schedules vary enormously — compare [Twofish](twofish.md) with
[ChaCha20](chacha20.md) — so a cipher that streams quickly can still be
expensive to start. Protocols that rekey often should weight this
figure heavily.

## Measurement detail

The setup cost is measured separately from bulk work, using the pass
rules from [how runs work](methodology.md).
