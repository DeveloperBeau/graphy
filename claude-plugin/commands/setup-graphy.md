---
description: Add the graphy code-navigation guidance to a CLAUDE.md so Claude prefers the graph over grep.
---

# /setup-graphy

Write the graphy code-navigation block into a `CLAUDE.md` file of the user's
choice. The `SessionStart` hook already injects this guidance every session;
this command is for users who also want it persisted in a memory file (for
other tools, or to keep it in the repo).

The block to write, including its idempotency markers:

```markdown
<!-- graphy-nav -->
## Code navigation
graphy knowledge graph of this repo available via MCP. Prefer over grep/file-reading for
symbols, callers, dependencies. `search_label` find symbol; `neighbors` callers, callees,
param/return types; `query_node` read signature; `shortest_path` trace links; `stats`
overview. Type edges: `neighbors` on a type lists every function using it, incl.
container-wrapped like `Vec<Widget>`. Read files only to confirm once graph points you there.
<!-- /graphy-nav -->
```

Steps:

1. Ask the user where to write it (use AskUserQuestion). Give each option a
   description so the user knows what it provides:
   - **User level** — `~/.claude/CLAUDE.md`. Loads in every project you open,
     not just this one. Private to your machine, never committed. Pick this to
     steer Claude toward the graph everywhere you use graphy.
   - **Project level** — `$CLAUDE_PROJECT_DIR/CLAUDE.md`. Lives at the repo
     root, scoped to this project. Commit it to share the guidance with the
     team, or leave it untracked to keep it to yourself. Committing is your
     choice.
   - **Local** — `$CLAUDE_PROJECT_DIR/CLAUDE.local.md`. Scoped to this project
     but private to you (usually gitignored), so it overrides project guidance
     without touching shared files. Pick this for personal, repo-specific tweaks.
2. Resolve the target path. Before writing, record whether the target file
   already exists — the gitignore step below depends on it.
3. Idempotency: if the file already contains the `<!-- graphy-nav -->` marker,
   tell the user it is already present and stop. Do not append a duplicate.
4. Append the block above to the target file (create the file and any parent
   directory if missing). Separate it from existing content with one blank line.
5. Gitignore prompt — only when the target is `CLAUDE.local.md` AND it did not
   exist before step 4 (you just created it): ask the user (AskUserQuestion)
   whether to add `CLAUDE.local.md` to `.gitignore`. If yes and the pattern is
   not already ignored, append `CLAUDE.local.md` to `$CLAUDE_PROJECT_DIR/.gitignore`
   (create the file if missing). Check `git check-ignore CLAUDE.local.md` first
   so you do not add a redundant line.
6. Confirm what was written and where, in one line.
