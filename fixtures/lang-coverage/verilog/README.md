# Verilog language coverage fixture

A minimal multi-file Verilog project used by `crates/graphy-core/tests/lang_verilog.rs`
to assert the Verilog extractor and the full Graphy pipeline emit expected nodes
and edges for every supported language feature.

## Files

| File | Demonstrates |
|---|---|
| `src/service.v` | module, parameter, input/output, always block, function, module instantiation (adder, counter) |
| `src/helpers.v` | module (adder, bit_and), parameter, assign |
| `src/types.v` | module with parameters (constants) |
| `src/empty.v` | empty file edge case |

## Notes on extractor scope

Verilog is a hardware description language. The extractor emits `module` and `function`
nodes. Module instantiation (`adder #(...) my_adder (...)`) creates a cross-module
dependency signal. `inherits`, `implements`, and `calls` are N/A for Verilog.

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_verilog.rs`.
Treat fixture + tests as one unit; change both in the same commit.
