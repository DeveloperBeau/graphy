# Expression syntax

Expressions follow ordinary infix notation with the usual precedence:
exponentiation binds tightest, then multiplication and division, then
addition and subtraction. Parentheses override everything.

## Numbers

Integers, decimals and scientific notation are all accepted, as are
underscores for grouping: `1_000_000` reads better than `1000000`.

## Variables

Assign with `=` and reference by name. Names are letters only. The
special name `ans` always holds the previous result, which the
[history tape](history.md) records alongside the expression itself.
