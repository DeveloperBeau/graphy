# Install

## From a release tarball

```bash
curl -fsSL https://raw.githubusercontent.com/DeveloperBeau/graphy/main/install.sh | sh   # macOS / Linux
irm https://raw.githubusercontent.com/DeveloperBeau/graphy/main/install.ps1 | iex        # Windows
```

The installer downloads the latest release for your platform, extracts the `graphy` binary and bundled plugins under `~/.graphy/` (override with `GRAPHY_HOME`), and adds `~/.graphy/bin` to your shell profile's `PATH`. Pin a version with `GRAPHY_VERSION=0.3.2 curl -fsSL ... | sh`.

Release archives also live on the [releases page](https://github.com/DeveloperBeau/graphy/releases) (`graphy-<version>-<arch>-<os>.tar.gz`).

## From source

```bash
cargo build --release
./target/release/graphy .
```

Then either copy the binary onto your `$PATH` (`cp target/release/graphy ~/.local/bin/`) or use `cargo install`:

```bash
cargo install --path crates/graphy-cli
```

Language plugins built alongside the binary live in `target/release/`. Point graphy at them once:

```bash
graphy plugins regenerate-manifest target/release
```

Or relocate them into the standard plugin dir:

```bash
mkdir -p ~/.graphy/plugins
cp target/release/libgraphy_plugin_*.dylib ~/.graphy/plugins/    # or *.so on Linux
graphy plugins regenerate-manifest ~/.graphy/plugins
```

## Building a release bundle

`tools/package-release.sh` produces a redistributable tarball with the binary, plugins, and manifest:

```bash
bash tools/package-release.sh
# dist/graphy-<version>-<arch>-<os>.tar.gz
```

## Verifying the install

```bash
graphy doctor && graphy plugins list
```

`doctor` prints the version and target architecture. `plugins list` should show 30+ language plugins; if it prints `no plugins registered`, your plugin dir is empty or not on the discovery path. See [plugins.md](plugins.md) for discovery order.

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/DeveloperBeau/graphy/main/uninstall.sh | sh   # macOS / Linux
irm https://raw.githubusercontent.com/DeveloperBeau/graphy/main/uninstall.ps1 | iex         # Windows
```

Removes the `~/.graphy/` tree (honors `GRAPHY_HOME`) and strips the `PATH` line the installer added to your shell profile (a `.graphy-bak` backup of the profile is kept). Not removed automatically:

- `cargo install` builds — `cargo uninstall graphy-cli`
- the Claude Code plugin — `/plugin uninstall graphy@graphy`
- per-project output dirs — `find . -type d -name graphy-out -prune -exec rm -rf {} +`
