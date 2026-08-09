# Box-drawing borders around rendered blocks.

border_rule() {
  local width="$1" ch="${2:--}" out=""
  while (( ${#out} < width )); do
    out+="$ch"
  done
  printf '+%s+\n' "$out"
}

border_wrap() {
  local width="$1" line
  border_rule "$width"
  while IFS= read -r line; do
    printf '|%s|\n' "$line"
  done
  border_rule "$width"
}
