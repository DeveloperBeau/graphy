# Greedy word wrapping.

wrap_line() {
  local line="$1" width="$2"
  while (( ${#line} > width )); do
    printf '%s\n' "${line:0:width}"
    line="${line:width}"
  done
  printf '%s\n' "$line"
}

wrap_text() {
  local width="$1" line
  while IFS= read -r line; do
    wrap_line "$line" "$width"
  done
}
