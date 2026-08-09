# Append-only results file under the working directory.

RESULTS_FILE="${CIPHBENCH_RESULTS:-results.csv}"

store_init() {
  : > "$RESULTS_FILE"
}

store_append() {
  printf '%s\n' "$1" >> "$RESULTS_FILE"
}

store_path() {
  echo "$RESULTS_FILE"
}
