# Error messages

Every error is one line, aimed at being quotable in a bug report.

## Parse errors

`unexpected token` points at the column with a caret. Check the
[expression syntax](expressions.md) for what is accepted.

## Evaluation errors

`domain error` and `overflow` come with the offending call attached;
the per-function pages reached from [built-in functions](functions.md)
note each function's valid domain. Anything unexplained belongs in
[troubleshooting](troubleshooting.md).
