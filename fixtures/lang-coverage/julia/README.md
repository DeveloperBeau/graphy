# Julia language coverage fixture

A minimal multi-file Julia project used by `crates/graphy-core/tests/lang_julia.rs`
to assert the Julia extractor and the full Graphy pipeline emit expected nodes
and edges for every supported language feature.

## Files

| File | Demonstrates |
|---|---|
| `src/Service.jl` | module, using, import, function, struct, const, calls |
| `src/Helpers.jl` | module, function, multiple dispatch, short-form fn |
| `src/Types.jl` | module, abstract type, struct, const |
| `src/Empty.jl` | empty file edge case |

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_julia.rs`.
Treat fixture + tests as one unit; change both in the same commit.
