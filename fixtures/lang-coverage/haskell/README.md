# Haskell language coverage fixture

A minimal multi-file Haskell project used by `crates/graphy-core/tests/lang_haskell.rs`
to assert the Haskell extractor and the full Graphy pipeline emit expected nodes
and edges for every supported language feature.

## Files

| File | Demonstrates |
|---|---|
| `src/Service.hs` | module, import (plain, qualified, selective), function, calls |
| `src/Helpers.hs` | import, functions, cross-file callee |
| `src/Types.hs` | type alias, newtype, data, class, instance |
| `src/Empty.hs` | empty file edge case |

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_haskell.rs`.
Treat fixture + tests as one unit; change both in the same commit.
