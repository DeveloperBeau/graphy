# Single-line live progress display.

PROGRESS_TOTAL=0
PROGRESS_DONE=0

progress_start() {
  PROGRESS_TOTAL="$1"
  PROGRESS_DONE=0
}

progress_tick() {
  PROGRESS_DONE=$(( PROGRESS_DONE + 1 ))
  printf '\r[%d/%d] %s' "$PROGRESS_DONE" "$PROGRESS_TOTAL" "$1" >&2
}

progress_done() {
  printf '\r%*s\r' 60 "" >&2
}
