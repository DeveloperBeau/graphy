# OCaml language coverage fixture

A minimal multi-file OCaml project used by `crates/graphy-core/tests/lang_ocaml.rs`
to assert the OCaml extractor and the full Graphy pipeline emit expected nodes
and edges for every supported language feature.

## Files

| File | Demonstrates |
|---|---|
| `src/service.ml` | open, module, let (top-level), calls |
| `src/helpers.ml` | let (top-level), let rec, submodule |
| `src/types.ml` | type alias, record, variant, module signature |
| `src/empty.ml` | empty file edge case |

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_ocaml.rs`.
Treat fixture + tests as one unit; change both in the same commit.
