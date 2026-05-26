# Erlang language coverage fixture

A minimal multi-file Erlang project used by `crates/graphy-core/tests/lang_erlang.rs`
to assert the Erlang extractor and the full Graphy pipeline emit expected nodes
and edges for every supported language feature.

## Files

| File | Demonstrates |
|---|---|
| `src/service.erl` | -module, -export, -import, function, external call (io:format) |
| `src/helpers.erl` | -module, -export, function clauses, cross-file callee |
| `src/types.erl` | -module, -export, -record, function |
| `src/empty.erl` | empty file edge case |

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_erlang.rs`.
Treat fixture + tests as one unit; change both in the same commit.
