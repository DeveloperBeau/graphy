# Objective-C language coverage fixture

A minimal multi-file ObjC project used by `crates/graphy-core/tests/lang_objc.rs`
to assert the ObjC extractor and the full Graphy pipeline emit expected nodes
and edges for every supported language feature.

## Files

| File | Demonstrates |
|---|---|
| `src/Service.h` | @interface with inheritance (NSObject), protocol conformance (Greet), property |
| `src/Service.m` | @implementation, method definitions, message sends |
| `src/Helpers.h` | @interface, class methods |
| `src/Helpers.m` | @implementation, method definitions |
| `src/Types.h` | @protocol, NS_ENUM typedef |
| `src/Empty.m` | empty file edge case |

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_objc.rs`.
Treat fixture + tests as one unit; change both in the same commit.
