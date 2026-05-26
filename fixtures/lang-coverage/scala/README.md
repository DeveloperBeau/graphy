# Scala language coverage fixture

Minimal multi-file Scala project used by `crates/graphy-core/tests/lang_scala.rs`.

## Files

| File | Demonstrates |
|---|---|
| `src/Types.scala` | trait, case class, class |
| `src/Helpers.scala` | object singleton, def, wildcard import |
| `src/Service.scala` | class, object, import styles, def, call |
| `src/Empty.scala` | empty file edge case |

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_scala.rs`.
