# Language coverage

37 languages ship as plugins.

| Language       | Suffix(es)                                           |
|----------------|------------------------------------------------------|
| Rust           | `.rs`                                                |
| Python         | `.py`                                                |
| JavaScript     | `.js`, `.jsx`, `.mjs`, `.cjs`, `.ejs`                |
| TypeScript     | `.ts`, `.tsx`                                        |
| Go             | `.go`                                                |
| Java           | `.java`                                              |
| C              | `.c`, `.h`                                           |
| C++            | `.cpp`, `.cc`, `.cxx`, `.hpp`                        |
| Ruby           | `.rb`                                                |
| C#             | `.cs`                                                |
| Bash           | `.sh`, `.bash`                                       |
| JSON           | `.json`                                              |
| Swift          | `.swift`                                             |
| Kotlin         | `.kt`, `.kts`                                        |
| PHP            | `.php`                                               |
| Scala          | `.scala`, `.sc`                                      |
| Lua            | `.lua`, `.luau`                                      |
| Zig            | `.zig`                                               |
| Elixir         | `.ex`, `.exs`                                        |
| Objective-C    | `.m`, `.mm`                                          |
| Julia          | `.jl`                                                |
| HTML           | `.html`, `.htm`                                      |
| CSS            | `.css`                                               |
| Groovy/Gradle  | `.groovy`, `.gradle`                                 |
| PowerShell     | `.ps1`                                               |
| Verilog        | `.v`, `.sv`                                          |
| Fortran        | `.f`, `.f90`, `.f95`, `.f03`, `.f08`, `.for`         |
| SQL            | `.sql`                                               |
| R              | `.r`                                                 |
| Dart           | `.dart`                                              |
| Svelte         | `.svelte`                                            |
| Markdown       | `.md`, `.mdx`, `.qmd`                                |
| YAML           | `.yaml`, `.yml`                                      |
| Pascal/Delphi  | `.pas`, `.pp`, `.dpr`, `.dpk`, `.lpr`, `.inc`        |
| Perl           | `.pl`, `.pm`, `.t`                                   |
| Haskell        | `.hs`                                                |
| OCaml          | `.ml`, `.mli`                                        |
| Erlang         | `.erl`, `.hrl`                                       |
| TOML           | `.toml`                                              |

## Node kinds

Each plugin emits nodes for top-level definitions of its language:

| Kind             | Languages where supported                                          |
|------------------|--------------------------------------------------------------------|
| `function`       | every language with named functions / methods / subroutines        |
| `class`          | OO languages (Python, Java, Kotlin, Swift, C#, C++, Ruby, ...)     |
| `struct`         | Rust, Swift, C, C++, Go, Zig, Julia                                |
| `enum`           | Rust, Swift, C, C++, Java, Kotlin, C#, TS, PHP, Zig                |
| `trait`          | Rust                                                               |
| `interface`      | Kotlin, Java, C#, TS, PHP, Dart, Groovy                            |
| `protocol`       | Swift, ObjC                                                        |
| `impl`           | Rust                                                               |
| `mod` / `module` | Rust, Erlang, Elixir, OCaml, Haskell, Julia, Fortran               |
| `namespace`      | C++, C#                                                            |
| `const`/`static` | Rust, Swift, Java, ...                                             |
| `type`           | Rust, OCaml, Haskell, TS (type alias), C (typedef)                 |
| `macro`          | Rust (`macro_rules!`)                                              |
| `record`         | Java, C#, Erlang                                                   |
| `mixin`          | Dart                                                               |
| `import`         | every language with module-level imports                           |
| `pair` / `key`   | TOML (key in section), JSON/YAML keys                              |

## Edge relations

Five edge relations are emitted, per-language as applicable:

| Relation     | Meaning                                                              |
|--------------|----------------------------------------------------------------------|
| `imports`    | `use` / `import` / `require` / `#include` / `@import`                |
| `calls`      | Direct invocations resolving to a local symbol (`Confidence::Inferred`) |
| `inherits`   | `class A: B` / `extends` / `: BaseClass` / Haskell `class ... where` |
| `implements` | `impl Trait for Type` / `implements I` / `: IFoo` (C#) / ObjC `<P>`  |
| `contains`   | Parent-child structural (mod → fn, impl → method, class → method)    |
| `references` | Type usage in function signatures (parameters + return types)        |

After deduplication the pipeline collapses `extern::<Name>` stubs onto canonical local definitions, so cross-file `imports` / `implements` / `references` resolve to the real target node.

## Imports

Braced and glob import forms are expanded into one extern node per imported symbol so dedup can resolve each independently:

| Source                            | Externs emitted                       |
|-----------------------------------|----------------------------------------|
| `use crate::a::{helper, other};`  | `helper`, `other`                      |
| `use std::io::Result as IoResult;`| `std::io::Result`, `IoResult`          |
| `from a import x, y`              | `a.x`, `a.y`                           |
| `import { A, B } from "./m"`      | `./m/A`, `./m/B`                       |
| `import java.util.*;`             | `java.util.*` (glob preserved)         |

Aliased imports emit both the canonical path AND the alias as separate externs so either lookup resolves through dedup.

Glob imports (`a::*`, `from a import *`, `import * as ns from "..."`, `java.util.*`) are kept intact and surface in the report as ambiguous candidates.

## Format-specific extraction

Markup and data formats follow an adapted shape:

| Format     | Nodes                                | Edges                                        |
|------------|--------------------------------------|----------------------------------------------|
| HTML       | id-bearing elements                  | `<a href>`, `<script src>`, `<link href>`    |
| CSS        | selectors (class, id, element)       | `@import`                                    |
| SQL        | tables / views / indexes (DDL)       | `references` for inline `REFERENCES` (FK)    |
| JSON       | top-level + nested keys              | `$ref` -> referenced schema node             |
| YAML       | keys at all depths                   | `references` for `*anchor` / `<<: *anchor`   |
| TOML       | sections + per-section `pair` nodes  | -                                            |
| Markdown   | headings                             | `references` for `[text](other.md)` links    |

## Confidence labels

Every edge carries a confidence label:

- `EXTRACTED` — explicitly stated in the source (an `import`, `#include`, `@import`, …).
- `INFERRED` — second-pass call-graph match (the callee's leaf name matches a defined symbol in the workspace).
- `AMBIGUOUS` — flagged for human review (e.g. two `helper` functions in different modules).
