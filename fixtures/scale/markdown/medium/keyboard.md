# Keyboard editing

The prompt uses readline, so the usual emacs-style bindings work.

## Line editing

Ctrl-A and Ctrl-E jump to the ends of the line; Ctrl-W deletes the word
behind the cursor, handy for retyping one argument of a call from
[built-in functions](functions.md).

## History navigation

Up and down move through past entries — the same entries the
[history tape](history.md) stores. Ctrl-R searches them incrementally.
