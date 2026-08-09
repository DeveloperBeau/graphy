# Troubleshooting

Most surprises come from precision settings or stale registers, so check
`set` output first.

## Common messages

`unknown name` usually means a variable was mistyped or has not been
assigned this session — remember variables are not registers, as
explained in [memory registers](memory.md).

`domain error` comes from functions asked for impossible values, such as
`asin(2)`; valid domains are noted in [built-in functions](functions.md).

## Reporting bugs

Include the tape excerpt from [the history tape](history.md) and the
output of `abacus --version` in any report.
