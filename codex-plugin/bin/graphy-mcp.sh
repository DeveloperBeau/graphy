#!/usr/bin/env bash
# MCP server launcher for the graphy claude-plugin.
#
# Claude Code resolves an mcpServers `command` against its own (parent) PATH,
# not the entry's `env` block. A GUI-launched Claude Code never sources the
# user's shell profile, so a binary installed to ~/.graphy/bin (release
# tarball) or ~/.cargo/bin (`cargo install`) is invisible and `command:
# "graphy"` fails to spawn. This wrapper — referenced via the always-resolvable
# ${CLAUDE_PLUGIN_ROOT} — finds the binary across the known install locations
# and execs the server. All arguments are forwarded to `graphy serve`.
set -euo pipefail

# `.exe` suffixes cover Windows installs running under Git Bash.
for candidate in \
  "$HOME/.graphy/bin/graphy" "$HOME/.cargo/bin/graphy" \
  "$HOME/.graphy/bin/graphy.exe" "$HOME/.cargo/bin/graphy.exe"; do
  if [[ -x "$candidate" ]]; then
    exec "$candidate" serve "$@"
  fi
done

# Fall back to PATH for system installs or a dev shell that already has it.
for name in graphy graphy.exe; do
  if command -v "$name" >/dev/null 2>&1; then
    exec "$name" serve "$@"
  fi
done

echo "graphy-mcp: graphy binary not found in ~/.graphy/bin, ~/.cargo/bin, or PATH" >&2
exit 127
