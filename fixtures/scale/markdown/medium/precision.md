# Precision and rounding

abacus computes with twenty internal digits and displays twelve by
default. Change the display with `set precision 6` at any prompt.

## Rounding mode

Half-even rounding is the default because it avoids drift when summing
long columns of figures. `set rounding half-up` restores schoolbook
behaviour.

## Angle mode

`set angles radians` or `set angles degrees` switches trigonometry, as
used by the functions listed in [built-in functions](functions.md).
Settings persist via the same file as [memory registers](memory.md).
