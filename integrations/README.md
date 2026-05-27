# graphy integrations

Editor-, agent-, and tool-level integrations that wrap the `graphy` CLI and its MCP server into a particular workflow. Each guide below is self-contained: install, configure, troubleshoot.

| Integration | Status | Doc |
|-------------|--------|-----|
| Claude Code | v1 (stable) | [claude-code.md](claude-code.md) |

## Adding an integration

Every integration document follows the same shape so users can scan them quickly:

1. **What you get** — the concrete surface area (commands, tool calls, UI hooks) the integration exposes.
2. **Prerequisites** — the `graphy` binary, plugin manifest, and any host-specific prerequisites (a particular CLI version, an MCP-aware host, etc.).
3. **Install** — copy/symlink/import steps for the host.
4. **Configuration** — environment variables and host-specific settings the integration reads.
5. **Workflow** — what the integration does automatically and what the user triggers manually.
6. **Troubleshooting** — known pitfalls and how to diagnose them.

Open a PR adding `integrations/<name>.md` and a row to the table above.
