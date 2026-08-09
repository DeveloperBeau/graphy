# Reading throughput figures

Throughput is bytes processed per second of steady-state work, taken
from the median pass as defined in [how runs work](methodology.md).

## Pitfalls

Hardware acceleration can hide a slow fallback path: a cipher can lead
the table on one machine and trail it on another. Always compare across
the whole fleet listed in [hardware notes](hardware.md).

## Related figures

Throughput says nothing about first-byte cost, which is the subject of
[latency](latency.md), and a high figure achieved with a large working
set will show up in [memory use](memory-use.md).
