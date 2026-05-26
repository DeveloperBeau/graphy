# Fortran language coverage fixture

A minimal multi-file Fortran project used by `crates/graphy-core/tests/lang_fortran.rs`
to assert the Fortran extractor and the full Graphy pipeline emit expected nodes
and edges for every supported language feature.

## Files

| File | Demonstrates |
|---|---|
| `src/service.f90` | module, use, subroutine, function, call |
| `src/helpers.f90` | module, subroutine, function, cross-file callees |
| `src/types.f90` | module, derived type, parameter |
| `src/empty.f90` | empty file edge case |

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_fortran.rs`.
Treat fixture + tests as one unit; change both in the same commit.
