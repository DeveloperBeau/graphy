# Svelte language coverage fixture

A minimal multi-file Svelte project used by `crates/graphy-core/tests/lang_svelte.rs`
to assert the Svelte extractor and the full Graphy pipeline emit expected nodes
and edges for every supported language feature.

## Files

| File | Demonstrates |
|---|---|
| `src/Service.svelte` | script block, import (component), export prop, reactive statement, function |
| `src/Helpers.svelte` | script block, export prop, function, reactive statement |
| `src/types.js` | plain JS module with exports |
| `src/empty.svelte` | empty file edge case |

## Notes on extractor scope

The Svelte extractor surfaces `script_element` and `style_element` nodes as
`svelte_block` kind. It does not descend into the JS content of the script block
to emit function/import nodes (those are handled by js_ts extractor for .js files).
The semantically interesting signal is the presence of a script block per component.
`inherits`, `implements`, and `calls` are N/A for the Svelte extractor.

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_svelte.rs`.
Treat fixture + tests as one unit; change both in the same commit.
