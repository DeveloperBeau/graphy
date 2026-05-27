# Plugin architecture

Languages ship as separate dynamic libraries. The core binary stays slim; per-language `cdylib` plugins are bundled in `plugins/` alongside the binary in release packages and lazy-loaded only on first encounter of a matching file extension.

## Manifest

`plugins/manifest.toml` enumerates every shipped plugin:

```toml
abi_version = 1

[[plugin]]
name = "graphy-plugin-rust"
version = "0.1.0"
file = "libgraphy_plugin_rust.dylib"
extensions = ["rs"]
sha256 = "..."
```

At startup graphy reads the manifest (cheap) and builds an `extension → plugin` index. The first time it encounters a matching file it `dlopen`s the dylib, verifies the recorded sha256, and caches the loaded handle. Subsequent files of the same language reuse the loaded library.

## Plugin discovery (priority order)

1. `$GRAPHY_PLUGIN_PATH` (colon-separated)
2. `$XDG_DATA_HOME/graphy/plugins/` (macOS: `~/Library/Application Support/graphy/plugins/`)
3. `./graphy-plugins/`
4. `<exe-dir>/plugins/`

## Plugin ABI

`graphy-plugin-api` defines the host/plugin contract via four C-ABI symbols:

```c
extern uint32_t graphy_plugin_abi_version(void);
extern const GraphyPluginMetadata *graphy_plugin_metadata(void);
extern GraphyPluginExtractResult graphy_plugin_extract(
    const char *path_utf8, size_t path_len,
    const uint8_t *src, size_t src_len);
extern void graphy_plugin_free(GraphyPluginExtractResult);
```

JSON is the boundary payload so plugins keep their own internal types. The `define_plugin!` macro generates every symbol from a single declarative call; per-plugin `lib.rs` is around 10 lines of boilerplate plus the tree-sitter walk.

## Writing a new plugin

1. Add a crate under `crates/plugins/graphy-plugin-<lang>/` with `crate-type = ["cdylib"]`.
2. Depend on `graphy-plugin-api` and `tree-sitter-<lang>`.
3. Implement an `extract` function that walks the tree-sitter parse tree and emits `Node`s and `Edge`s.
4. Wire it up with `define_plugin!` (see existing plugins for examples).
5. `cargo build --release` produces a `dylib`/`so`.
6. `graphy plugins install <path-to-dylib>` copies it into the default plugin dir and refreshes the manifest, or run `graphy plugins regenerate-manifest <dir>` if you placed it manually.
