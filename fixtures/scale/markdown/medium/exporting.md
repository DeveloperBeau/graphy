# Exporting the tape

`export tape.csv` writes the whole tape as CSV, one row per evaluation.

## Columns

Entry number, expression, result and timestamp — the same fields shown
by the `history` command from [the history tape](history.md).

## Partial exports

`export --last 50 tape.csv` limits the rows. Precision of exported
results follows the display setting from
[precision and rounding](precision.md), not the internal digits.
