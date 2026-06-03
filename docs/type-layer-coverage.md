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

Columns are `full` / `partial` / `none`. Rows are added as each grammar's
extractor lands. Statically typed languages (Go, Java, C#, TypeScript, C++,
Swift, Kotlin, Scala) target `full`. Python and PHP are `partial` (types only
where annotations are present). JavaScript, Ruby, Lua, and Bash are `none`
(no type information in the grammar).

`partial` means types are emitted only where a type annotation is present.
