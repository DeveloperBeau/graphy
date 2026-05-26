# Bash language coverage fixture

Minimal multi-file Bash project used by `crates/graphy-core/tests/lang_bash.rs`.

## Files

| File | Demonstrates |
|---|---|
| `types.sh` | variable assignment, function (keyword form) |
| `helpers.sh` | POSIX function, keyword function |
| `service.sh` | source, dot-source, function, call |
| `empty.sh` | empty file edge case |

## Notes

Bash has no classes or inheritance. No class/inherits/implements assertions.
