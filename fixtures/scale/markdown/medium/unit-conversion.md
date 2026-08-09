# Unit conversion

The `to` operator converts between named units: `3.5 km to mi`.

## Supported units

Length, mass, temperature and data sizes ship built in. The full list
prints with `units`. Compound units are not yet parsed.

## Precision notes

Conversions use exact factors where they exist and round only at
display, as set in [precision and rounding](precision.md). Converted
results land on the tape like any other entry, per
[the history tape](history.md).
