# Release flow

How to cut a graphy release. The version lives in more than one file; missing
one ships an inconsistent release.

## Version locations (bump ALL of these together)

1. `Cargo.toml` — `[workspace.package] version`. Every crate inherits it via
   `version.workspace = true`, so this is the only Cargo edit.
2. `Cargo.lock` — run `cargo update -w` after editing `Cargo.toml` to rewrite
   the workspace crate versions.
3. `claude-plugin/.claude-plugin/plugin.json` — the Claude Code plugin manifest
   `version`. This is separate from Cargo and is easy to forget.

`.claude-plugin/marketplace.json` has no version field. `docs/plugins.md`
contains an example dylib-manifest snippet with a `version` line; it is
illustrative, not the release version. Leave both alone.

## Steps

1. Bump the three version locations above on a branch.
2. Open a PR, let CI pass (clippy / rustfmt / test), merge to `main`.
3. Tag the merge commit: `git tag -a vX.Y.Z -m "graphy vX.Y.Z"` then
   `git push origin vX.Y.Z`. The tag MUST point at a commit where all three
   version files already read the new version.
4. Pushing the tag triggers `.github/workflows/release.yml`, which builds the
   per-platform artifacts and publishes the GitHub release.
5. Set the release notes: `gh release edit vX.Y.Z --notes-file <notes>`.

## Gotchas

- The git tag is the release. To move or re-cut a tag, delete it first
  (`gh release delete vX.Y.Z --cleanup-tag --yes`, then re-tag and push);
  pushing the same tag name again does not update it.
- Re-cutting a tag re-runs the full release build even when the artifacts are
  unchanged.
- Docs-only changes (README, this file) do not need a new tag; they are served
  from the default branch.
- Never admin-merge a release PR on a compile-only check. The `test` job must be
  green.
