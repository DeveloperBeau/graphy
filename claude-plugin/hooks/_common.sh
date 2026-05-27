#!/usr/bin/env bash
# Shared helpers for graphy claude-plugin hooks.
#
# Two functions are exported:
#
#   graphy_acquire_lock <lock_path>
#       Atomically claim a build lock. Returns 0 on success (caller may fork
#       the build), 1 if another live process already holds it. Stale locks
#       (dead PID or mtime older than 30 min) are reclaimed automatically.
#
#   graphy_fork_build <workspace> <out_root> <lock_path> <log_path>
#       Background a `graphy <workspace> --out <out_root>` build. The forked
#       subshell owns the lock and removes it on exit. The caller's PID space
#       is decoupled from the build via `disown`.
#
# These hooks set GRAPHY_AUTO_GITIGNORE=1 so the CLI knows it is running
# under the claude-plugin and may safely append `graphy-out/` to an existing
# .gitignore. Standalone CLI users do not get this behavior.

# Idempotent guard so we don't re-source.
if [[ "${__GRAPHY_COMMON_SH_SOURCED:-}" == "1" ]]; then
  return 0 2>/dev/null || exit 0
fi
__GRAPHY_COMMON_SH_SOURCED=1

# Plugin-side opt-in for the CLI gitignore writer. Standalone `graphy` runs
# (without this env var) leave .gitignore alone.
export GRAPHY_AUTO_GITIGNORE=1

# Treat a lock as stale after 30 minutes regardless of PID liveness — guards
# against PID reuse where kill -0 still succeeds against an unrelated process.
GRAPHY_LOCK_STALE_SECONDS="${GRAPHY_LOCK_STALE_SECONDS:-1800}"

graphy_log() {
  [[ -n "${GRAPHY_VERBOSE:-}" ]] && printf '[graphy-hook] %s\n' "$*" >&2
  return 0
}

# stat the mtime portably (BSD vs GNU find/stat).
graphy_mtime() {
  local path="$1"
  stat -f %m "$path" 2>/dev/null || stat -c %Y "$path" 2>/dev/null || echo 0
}

graphy_acquire_lock() {
  local lock="$1"
  local now pid age
  if [[ -f "$lock" ]]; then
    pid="$(cat "$lock" 2>/dev/null || true)"
    now="$(date +%s)"
    age=$(( now - $(graphy_mtime "$lock") ))
    if (( age > GRAPHY_LOCK_STALE_SECONDS )); then
      graphy_log "lock older than ${GRAPHY_LOCK_STALE_SECONDS}s; reclaiming"
      rm -f "$lock"
    elif [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
      graphy_log "build already running (pid $pid)"
      return 1
    else
      graphy_log "stale lock (pid $pid dead); reclaiming"
      rm -f "$lock"
    fi
  fi
  # Atomic acquire: noclobber redirect fails if another process raced us.
  ( set -C; printf '%d\n' "$$" > "$lock" ) 2>/dev/null || {
    graphy_log "lock acquire race; another hook claimed it"
    return 1
  }
  return 0
}

graphy_fork_build() {
  local workspace="$1" out_root="$2" lock="$3" log="$4"
  (
    trap 'rm -f "$lock"' EXIT
    # Record the actual build PID so the next hook can probe liveness.
    printf '%d\n' "$$" > "$lock"
    "${GRAPHY_BIN:-graphy}" "$workspace" --out "$out_root" >"$log" 2>&1 || true
  ) >/dev/null 2>&1 &
  disown 2>/dev/null || true
}
