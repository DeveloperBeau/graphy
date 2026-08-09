# Final one-screen digest after a full run.

summary_row() {
  printf '%-14s %10s %10s\n' "$1" "$2" "$3"
}

summary_print() {
  local count
  count=$(registered_count)
  echo "ciphers run: $count"
  summary_row cipher bytes time
  summary_row ------ ----- ----
}
