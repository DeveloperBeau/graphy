# Wrapping

inkroll rewraps at the terminal width by default, honouring hanging
indents so wrapped continuation lines stay aligned.

## Choosing a width

`--width 100` is a good ceiling for compiler output; below 60 columns
hanging indents start to dominate the line.

## Disabling

`--no-wrap` passes long lines through untouched, useful for the CSV case
in [piping patterns](piping.md). The flag summary is in
[styles and flags](styles.md).
