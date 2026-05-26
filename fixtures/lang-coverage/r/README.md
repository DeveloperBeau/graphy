# R language coverage fixture

Minimal multi-file R project used by `crates/graphy-core/tests/lang_r.rs`.

## Files

| File | Demonstrates |
|---|---|
| `types.R` | function assignment, constants |
| `helpers.R` | library, function assignment (arrow and equals) |
| `service.R` | library, require, source, function assignment |
| `empty.R` | empty file edge case |

## Notes

R has no built-in class/inheritance syntax at the language level. No class/inherits assertions.
