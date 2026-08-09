# Result formatting helpers.

fmt_number() {
  local n="$1"
  printf '%d' "$n"
}

fmt_result() {
  local n
  n=$(fmt_number "$1")
  printf '= %s\n' "$n"
}

fmt_hex() {
  printf '0x%x' "$1"
}
