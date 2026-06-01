#!/usr/bin/env bash
# Build the graphy binary + every plugin crate in release mode, generate a
# manifest, and produce a tarball ready to upload as a release artifact.
#
# Output: dist/graphy-<version>-<arch>-<os>.{tar.gz|zip} containing:
#   graphy[.exe]              (binary)
#   plugins/manifest.toml
#   plugins/lib*.{dylib,so,dll}
#   README.md, LICENSE
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO"

VERSION="$(awk -F'"' '/^version/ {print $2; exit}' Cargo.toml)"
[[ -z "$VERSION" ]] && VERSION="$(awk -F'"' '/^version/ {print $2; exit}' crates/graphy-cli/Cargo.toml)"
[[ -z "$VERSION" ]] && VERSION="0.0.0"

case "$(uname -s)" in
  Darwin) OS="macos";   DYLIB_EXT="dylib"; BIN="graphy";     ARCHIVE="tar.gz" ;;
  Linux)  OS="linux";   DYLIB_EXT="so";    BIN="graphy";     ARCHIVE="tar.gz" ;;
  MINGW*|MSYS*|CYGWIN*) OS="windows"; DYLIB_EXT="dll"; BIN="graphy.exe"; ARCHIVE="zip" ;;
  *) echo "unsupported OS: $(uname -s)"; exit 1 ;;
esac
ARCH="$(uname -m)"

# Portable sha256: macos ships `shasum`, linux/git-bash ship `sha256sum`.
sha256_of() {
  if command -v sha256sum >/dev/null 2>&1; then sha256sum "$1"
  else shasum -a 256 "$1"; fi
}

STAGE="$REPO/dist/stage"
OUT="$REPO/dist"
rm -rf "$STAGE"
mkdir -p "$STAGE/plugins" "$OUT"

echo "[1/4] building graphy + plugins (release)…"
PLUGIN_CRATES=$(ls -d crates/plugins/graphy-plugin-* 2>/dev/null | xargs -n1 basename)
PLUGIN_ARGS=()
for c in $PLUGIN_CRATES; do PLUGIN_ARGS+=(-p "$c"); done
cargo build --release -p graphy-cli "${PLUGIN_ARGS[@]}" 2>&1 | tail -20

echo "[2/4] staging artifacts…"
cp "$REPO/target/release/$BIN" "$STAGE/$BIN"
for c in $PLUGIN_CRATES; do
  stem="$(echo "$c" | tr - _)"
  case "$OS" in
    macos) src="$REPO/target/release/lib${stem}.dylib" ;;
    linux) src="$REPO/target/release/lib${stem}.so" ;;
    windows) src="$REPO/target/release/${stem}.dll" ;;
  esac
  if [[ -f "$src" ]]; then
    cp "$src" "$STAGE/plugins/"
  else
    echo "  warn: missing $src"
  fi
done
cp "$REPO/README.md" "$STAGE/" 2>/dev/null || true

echo "[3/4] generating manifest.toml…"
"$STAGE/$BIN" plugins regenerate-manifest "$STAGE/plugins" >/dev/null

echo "[4/4] archiving…"
ART="$OUT/graphy-${VERSION}-${ARCH}-${OS}.${ARCHIVE}"
rm -f "$ART"
if [[ "$ARCHIVE" == "zip" ]]; then
  # GitHub windows runners ship 7z; produces a standard zip Expand-Archive reads.
  ( cd "$STAGE" && 7z a -tzip "$ART" ./* >/dev/null )
else
  ( cd "$STAGE" && tar -czf "$ART" . )
fi
SHA="$(sha256_of "$ART" | awk '{print $1}')"
echo "$SHA  $(basename "$ART")" > "${ART}.sha256"

echo
echo "==> $ART"
echo "    sha256: $SHA"
echo "    size:   $(du -h "$ART" | awk '{print $1}')"
