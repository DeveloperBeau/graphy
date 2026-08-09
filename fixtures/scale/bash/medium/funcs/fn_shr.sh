# Shift right.

calc_shr() {
  local n="$1" k="$2"
  if (( k < 0 )); then
    echo "$n"
    return
  fi
  echo $(( n >> k ))
}
