# Type layer coverage

graphy's typed signature layer adds type-aware nodes and edges where a
language's grammar carries type information. This table tracks per-language
support. Languages whose grammar has no type annotations emit functions and
parameter names but no type nodes or edges.

## Node kinds and edge relations

- Node kind `type`: a type referenced in a signature, id `extern::<Type>`,
  collapsed onto a local definition by dedup when one exists.
- Edge `has_param` (function to type): metadata `{name, index}`.
- Edge `returns` (function to type): no metadata.
- Edge `has_field` (struct/class to type): metadata `{name}`.
- Node `signature` payload: `{params: [{name, ty?}], returns?, fields: [{name, ty?}]}`.

`ty` is the textual type as written; it is absent where the grammar carries
no type for that position.

## Generic inner types

Edges target the inner type arguments of a generic, not the outer container.
`fn f(x: Vec<Widget>)` emits `has_param x -> extern::Widget`, not
`extern::Vec`, so a "who uses Widget" query finds container-wrapped uses.
Stdlib containers (`Vec`, `List`, `Map`, `Optional`, `Promise`, `Array`, and
their per-language equivalents) are suppressed; only the inner types get edges.

A user-defined generic keeps its own edge plus its arguments': `Pair<Foo, Bar>`
emits edges to `Pair`, `Foo`, and `Bar`, all sharing the parameter name and
index. Nesting recurses: `Vec<Pair<Foo, Bar>>` emits `Pair`, `Foo`, and `Bar`
(`Vec` suppressed). Identical leaves at one position dedupe, so `Pair<Foo, Foo>`
yields a single `Foo` edge.

The `signature` payload `ty` is unchanged: it keeps the full textual type
(`Vec<Widget>`). Only the edge targets differ.

This applies to the statically typed languages plus annotation-gated Python:
Rust, Go, Java, C#, TypeScript, C++, Swift, Kotlin, Scala, Python. PHP type
hints and SQL types have no generic syntax, so the behavior does not apply
there.

## Per-language support

| Language | params | returns | fields | Notes |
|----------|--------|---------|--------|-------|
| Rust | full | full | full | pilot extractor |
| Go | full | full | full | static types |
| Scala | full | full | full | static types |
| Kotlin | full | full | full | static types |
| C# | full | full | full | static types |
| TypeScript | full | full | full | static types |
| Swift | full | full | full | static types |
| C++ | full | full | full | static types |
| Java | full | full | full | static types, class fields |
| Ruby | names | none | none | no type info in grammar |
| Python | partial | partial | partial | only where annotated |
| PHP | partial | partial | partial | only where annotated |
| Lua | names | none | none | no type info in grammar |
| Bash | none | none | none | no parameters in grammar |
| SQL | partial | partial | none | typed CREATE FUNCTION arguments and return |
| HTML | none | none | none | markup, no functions or types |
| CSS | none | none | none | stylesheet, no functions or types |
| JSON | none | none | none | data, no functions or types |
| YAML | none | none | none | data, no functions or types |
| TOML | none | none | none | data, no functions or types |
| Markdown | none | none | none | prose, no functions or types |
| Svelte | none | none | none | component markup, no signatures |

Columns are `full` / `partial` / `none`. Rows are added as each grammar's
extractor lands. Statically typed languages (Go, Java, C#, TypeScript, C++,
Swift, Kotlin, Scala) target `full`. Python and PHP are `partial` (types only
where annotations are present). JavaScript, Ruby, Lua, and Bash are `none`
(no type information in the grammar).

`partial` means types are emitted only where a type annotation is present.
