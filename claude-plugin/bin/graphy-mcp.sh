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

for candidate in "$HOME/.graphy/bin/graphy" "$HOME/.cargo/bin/graphy"; do
  if [[ -x "$candidate" ]]; then
    exec "$candidate" serve "$@"
  fi
done

# Fall back to PATH for system installs or a dev shell that already has it.
if command -v graphy >/dev/null 2>&1; then
  exec graphy serve "$@"
fi

echo "graphy-mcp: graphy binary not found in ~/.graphy/bin, ~/.cargo/bin, or PATH" >&2
exit 127
