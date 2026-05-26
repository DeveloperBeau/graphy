# Lua language coverage fixture

Minimal multi-file Lua project used by `crates/graphy-core/tests/lang_lua.rs`.

## Files

| File | Demonstrates |
|---|---|
| `src/types.lua` | module table, functions |
| `src/helpers.lua` | global function, local function |
| `src/service.lua` | require, function, method-style, call |
| `src/empty.lua` | empty file edge case |

## Notes

Lua has no class/inheritance syntax. No inherits or implements assertions.
