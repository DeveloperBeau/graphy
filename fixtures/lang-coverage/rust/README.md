# Rust language coverage fixture

A minimal multi-file Rust project used by `crates/graphy-core/tests/lang_rust.rs`
to assert that the Rust extractor and the full Graphy pipeline emit the expected
nodes and edges for every supported language feature.

## Files

| File | Demonstrates |
|---|---|
| `src/lib.rs` | module declarations (`mod`), glob re-export, top-level fn |
| `src/service.rs` | struct, impl, `impl Trait for Type` (implements edge), single/braced/aliased/glob imports, cross-file call, external call (`println!`) |
| `src/helpers.rs` | top-level fn, called cross-file from `service.rs` |
| `src/types.rs` | enum, trait, type alias, const, static |
| `src/empty.rs` | empty file edge case |

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_rust.rs`.
Treat the fixture and its tests as one unit; change both in the same commit.
