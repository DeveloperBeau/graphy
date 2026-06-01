#!/usr/bin/env bash
# graphy uninstaller. Removes what install.sh created: the ~/.graphy tree
# (binary + plugins) and the PATH line added to your shell profile.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/DeveloperBeau/graphy/main/uninstall.sh | sh
#
# Honors GRAPHY_HOME if you installed to a custom location.
set -euo pipefail

INSTALL_ROOT="${GRAPHY_HOME:-$HOME/.graphy}"

if [[ -d "$INSTALL_ROOT" ]]; then
  echo "graphy uninstall: removing $INSTALL_ROOT"
  rm -rf "$INSTALL_ROOT"
else
  echo "graphy uninstall: $INSTALL_ROOT not found (nothing to remove)"
fi

# Strip the PATH entry the installer appended (and its `# graphy installer`
# comment) from the common shell profiles. A timestamped backup is kept.
for PROFILE in "$HOME/.zshrc" "$HOME/.bashrc" "$HOME/.config/fish/config.fish"; do
  [[ -f "$PROFILE" ]] || continue
  if grep -qE '# graphy installer|\.graphy/bin' "$PROFILE"; then
    cp "$PROFILE" "$PROFILE.graphy-bak"
    tmp="$(mktemp)"
    grep -vE '# graphy installer|\.graphy/bin' "$PROFILE" > "$tmp"
    mv "$tmp" "$PROFILE"
    echo "graphy uninstall: removed PATH entry from $PROFILE (backup: $PROFILE.graphy-bak)"
  fi
done

echo
echo "graphy uninstalled. Restart your shell to drop it from PATH."
echo
echo "Not removed (do these yourself if you want):"
echo "  - cargo installs:    cargo uninstall graphy-cli"
echo "  - Claude Code plugin: /plugin uninstall graphy@graphy"
echo "  - per-project output: find . -type d -name graphy-out -prune -exec rm -rf {} +"
