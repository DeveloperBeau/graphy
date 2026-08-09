# Shift left.

calc_shl() {
  local n="$1" k="$2"
  if (( k < 0 )); then
    echo "$n"
    return
  fi
  echo $(( n << k ))
}
