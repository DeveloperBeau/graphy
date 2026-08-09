# Absolute value.

calc_iabs() {
  local n="$1"
  if (( n < 0 )); then
    echo $(( -n ))
  else
    echo "$n"
  fi
}
