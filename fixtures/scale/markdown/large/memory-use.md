# Reading memory figures

The store records the peak working set during bulk encryption and the
size of the expanded key material.

## Interpreting the numbers

Table-driven designs such as [Blowfish](blowfish.md) trade memory for
speed; bit-sliced designs like [Serpent](serpent.md) go the other way.
Neither is wrong — the figure exists so the trade is visible.

## Constrained targets

For the small board in [hardware notes](hardware.md), expanded key
material dominates; the lightweight entries [Speck](speck.md) and
[PRESENT](present.md) exist mostly for this comparison.
