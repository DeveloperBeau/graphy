# Pascal language coverage fixture

A minimal multi-file Pascal (Object Pascal / Delphi) project used by
`crates/graphy-core/tests/lang_pascal.rs` to assert the Pascal extractor
and the full Graphy pipeline emit expected nodes and edges for every
supported language feature.

## Files

| File | Demonstrates |
|---|---|
| `src/service.pas` | unit, uses, type (class), procedure, function, calls |
| `src/helpers.pas` | unit, function, cross-file callees |
| `src/types.pas` | unit, const, type (record, enum) |
| `src/empty.pas` | empty file edge case |

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_pascal.rs`.
Treat fixture + tests as one unit; change both in the same commit.
