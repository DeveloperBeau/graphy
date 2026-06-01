#!/usr/bin/env bash
# graphy installer — downloads the latest release for the current platform,
# extracts it under ~/.graphy/, and ensures ~/.graphy/bin is on PATH.
#
# Usage:
#   curl -fsSL https://example.com/graphy/install.sh | sh
#   # or pin a version:
#   GRAPHY_VERSION=0.1.0 curl -fsSL ... | sh
#
# The release tarball layout is documented in tools/package-release.sh.
set -euo pipefail

REPO="${GRAPHY_REPO:-https://github.com/DeveloperBeau/graphy}"
VERSION="${GRAPHY_VERSION:-latest}"
INSTALL_ROOT="${GRAPHY_HOME:-$HOME/.graphy}"

case "$(uname -s)" in
  Darwin) OS="macos" ;;
  Linux)  OS="linux" ;;
  *) echo "unsupported OS: $(uname -s)"; exit 1 ;;
esac
ARCH="$(uname -m)"
# macOS ships a single universal (arm64 + x86_64) binary.
[[ "$OS" = "macos" ]] && ARCH="universal"

if [[ "$VERSION" = "latest" ]]; then
  echo "graphy install: resolving latest version from $REPO/releases/latest"
  RESOLVED="$(curl -fsSL -o /dev/null -w '%{url_effective}' "$REPO/releases/latest" \
    | awk -F/ '{print $NF}')"
  VERSION="${RESOLVED#v}"
fi
[[ -z "$VERSION" ]] && { echo "could not resolve version"; exit 1; }

TARBALL="graphy-${VERSION}-${ARCH}-${OS}.tar.gz"
URL="$REPO/releases/download/v${VERSION}/${TARBALL}"

echo "graphy install: downloading $URL"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
curl -fsSL "$URL" -o "$TMP/$TARBALL"
curl -fsSL "$URL.sha256" -o "$TMP/$TARBALL.sha256" || true

if [[ -f "$TMP/$TARBALL.sha256" ]]; then
  echo "graphy install: verifying sha256"
  ( cd "$TMP" && shasum -a 256 -c "$TARBALL.sha256" )
fi

mkdir -p "$INSTALL_ROOT/bin" "$INSTALL_ROOT/plugins"
echo "graphy install: extracting to $INSTALL_ROOT"
tar -xzf "$TMP/$TARBALL" -C "$INSTALL_ROOT"

# Move the binary into bin/ if the archive shipped it at the root.
if [[ -f "$INSTALL_ROOT/graphy" ]]; then
  mv -f "$INSTALL_ROOT/graphy" "$INSTALL_ROOT/bin/graphy"
  chmod +x "$INSTALL_ROOT/bin/graphy"
fi

# Add to PATH for common shells (idempotent).
PROFILE=""
case "$SHELL" in
  */zsh)  PROFILE="$HOME/.zshrc" ;;
  */bash) PROFILE="$HOME/.bashrc" ;;
  */fish) PROFILE="$HOME/.config/fish/config.fish" ;;
esac
if [[ -n "$PROFILE" && -f "$PROFILE" ]]; then
  if ! grep -q ".graphy/bin" "$PROFILE" 2>/dev/null; then
    echo "" >> "$PROFILE"
    echo "# graphy installer" >> "$PROFILE"
    echo "export PATH=\"$INSTALL_ROOT/bin:\$PATH\"" >> "$PROFILE"
    echo "graphy install: added $INSTALL_ROOT/bin to PATH in $PROFILE"
  fi
fi

echo
echo "graphy ${VERSION} installed."
echo "  binary:  $INSTALL_ROOT/bin/graphy"
echo "  plugins: $INSTALL_ROOT/plugins"
echo
echo "Run: $INSTALL_ROOT/bin/graphy doctor"
echo "     $INSTALL_ROOT/bin/graphy plugins list"
