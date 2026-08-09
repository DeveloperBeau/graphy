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
| `calls`      | Invocations. Bare names resolve against local + imported symbols; qualified callees (`hello.run`, `mod::helper`) whose head is a known symbol route through an extern node (`Confidence::Inferred`) |
| `inherits`   | `class A: B` / `extends` / `: BaseClass` / Haskell `class ... where` |
| `implements` | `impl Trait for Type` / `implements I` / `: IFoo` (C#) / ObjC `<P>`  |
| `contains`   | Structural anchoring: every definition gets a `file → definition` edge, plus parent-child forms (mod → fn, impl → method, class → method) |
| `references` | Type usage in function signatures (parameters + return types)        |

After deduplication the pipeline collapses `extern::<Name>` stubs onto canonical local definitions, so cross-file `imports` / `calls` / `implements` / `references` resolve to the real target node. Extern labels are matched on both `::` and `.` separators, so dotted module paths (`app.util.say`, `com.example.Service`) resolve the same as Rust-style paths. Calls to genuinely external symbols (`fmt.Println`, `Console.WriteLine`) keep their extern target rather than disappearing — no node in the graph is left without at least one edge.

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

## Languages with no tree-sitter grammar (v1 future feature)

Every language above rides an existing tree-sitter grammar. A handful of
notable languages have no usable tree-sitter grammar at all as of the
2026-08 survey, meaning graphy can't add them the normal way (bind to an
existing grammar crate, write an extractor). Supporting these would require
a hand-written parsing framework of graphy's own — out of scope for now,
tracked here as a future feature rather than a near-term plugin:

| Language | Why it's notable | Status checked |
|----------|-------------------|-----------------|
| F*       | Verification-oriented ML dialect used in formally-verified systems (e.g. parts of HACL*, Project Everest) | Only an old TextMate grammar found; no tree-sitter grammar published anywhere |
| Grain    | Small but real WASM-targeting functional language | No `tree-sitter-grain` repo found in any registry searched |
| Vale     | Memory-safety-focused systems language with an active if small community | No `tree-sitter-vale` repo found anywhere searched |
| Carbon   | Google's experimental C++ successor language | Grammar tooling exists only inside Carbon's own build (`utils/tree_sitter/`); nothing published as a standalone, reusable grammar |

If graphy adds support for any of these, it'll need its own parser (hand-rolled
recursive-descent or similar) rather than the plugin pattern documented
above, since there's no upstream grammar to bind to.
