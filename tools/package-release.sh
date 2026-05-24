#!/usr/bin/env bash
# Build the graphy binary + every plugin crate in release mode, generate a
# manifest, and produce a tarball ready to upload as a release artifact.
#
# Output: dist/graphy-<version>-<arch>-<os>.tar.gz containing:
#   graphy                    (binary)
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
  Darwin) OS="macos"; DYLIB_EXT="dylib" ;;
  Linux)  OS="linux"; DYLIB_EXT="so" ;;
  MINGW*|MSYS*|CYGWIN*) OS="windows"; DYLIB_EXT="dll" ;;
  *) echo "unsupported OS: $(uname -s)"; exit 1 ;;
esac
ARCH="$(uname -m)"

STAGE="$REPO/dist/stage"
OUT="$REPO/dist"
rm -rf "$STAGE"
mkdir -p "$STAGE/plugins" "$OUT"

echo "[1/4] building graphy + plugins (release)…"
PLUGIN_CRATES=$(ls -d crates/graphy-plugin-* | grep -v graphy-plugin-api | xargs -n1 basename)
PLUGIN_ARGS=()
for c in $PLUGIN_CRATES; do PLUGIN_ARGS+=(-p "$c"); done
cargo build --release -p graphy-cli "${PLUGIN_ARGS[@]}" 2>&1 | tail -20

echo "[2/4] staging artifacts…"
cp "$REPO/target/release/graphy" "$STAGE/graphy"
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
"$STAGE/graphy" plugins regenerate-manifest "$STAGE/plugins" >/dev/null

echo "[4/4] archiving…"
TAR="$OUT/graphy-${VERSION}-${ARCH}-${OS}.tar.gz"
( cd "$STAGE" && tar -czf "$TAR" . )
SHA="$(shasum -a 256 "$TAR" | awk '{print $1}')"
echo "$SHA  $(basename "$TAR")" > "${TAR}.sha256"

echo
echo "==> $TAR"
echo "    sha256: $SHA"
echo "    size:   $(du -h "$TAR" | awk '{print $1}')"
