# Release flow

How to cut a graphy release. The version lives in more than one file; missing
one ships an inconsistent release.

## Branches

graphy ships from two long-lived branches:

- `release` — the default branch. Stable line; every version tag (`vX.Y.Z`)
  is cut from a commit on this branch. This is what `install.sh` and
  end users track.
- `develop` — ongoing feature work, including work not yet ready for a
  stable tag (e.g. the Codex plugin, which currently only exists on
  `develop`). Feature PRs land here first; a maintainer decides when a
  `develop` commit is ready to backport/promote to `release`.

Bugfixes and docs changes that apply to both branches should be raised as
separate PRs against each — cherry-pick rather than merge `develop` into
`release` wholesale, since `release` intentionally excludes work still in
progress on `develop`.

## Version locations (bump ALL of these together)

1. `Cargo.toml` — `[workspace.package] version`. Every crate inherits it via
   `version.workspace = true`, so this is the only Cargo edit.
2. `Cargo.lock` — run `cargo update -w` after editing `Cargo.toml` to rewrite
   the workspace crate versions.
3. `claude-plugin/.claude-plugin/plugin.json` — the Claude Code plugin manifest
   `version`. This is separate from Cargo and is easy to forget.
4. `codex-plugin/.codex-plugin/plugin.json` — the Codex plugin manifest
   `version`. Only present on `develop` (and any branch that has merged the
   Codex plugin work); does not exist on `release` today.

`.claude-plugin/marketplace.json` has no version field. `docs/plugins.md`
contains an example dylib-manifest snippet with a `version` line; it is
illustrative, not the release version. Leave both alone.

## Steps

1. Bump the version locations above (skip any that don't exist on the target
   branch) on a branch cut from `release` (or `develop`, for a pre-release
   tag off that line).
2. Open a PR against `release` (or `develop`), let CI pass (clippy / rustfmt
   / test), merge.
3. Tag the merge commit: `git tag -a vX.Y.Z -m "graphy vX.Y.Z"` then
   `git push origin vX.Y.Z`. The tag MUST point at a commit where every
   present version file already reads the new version.
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
- A tag cut from `develop` (e.g. a `-beta.N` pre-release) is still a real tag
  against real commits — the version-file rules above apply the same way,
  just with `codex-plugin`'s manifest included.
