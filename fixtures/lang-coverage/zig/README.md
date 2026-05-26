# Zig language coverage fixture

A minimal multi-file Zig project used by `crates/graphy-core/tests/lang_zig.rs`
to assert the Zig extractor and the full Graphy pipeline emit expected nodes
and edges for every supported language feature.

## Files

| File | Demonstrates |
|---|---|
| `src/service.zig` | @import (std + local), fn, struct with method, calls |
| `src/helpers.zig` | top-level functions, cross-file callee |
| `src/types.zig` | struct, enum, union, const |
| `src/empty.zig` | empty file edge case |

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_zig.rs`.
Treat fixture + tests as one unit; change both in the same commit.
