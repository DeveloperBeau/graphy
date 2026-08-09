# Minimum of two integers.

calc_imin() {
  local a="$1" b="$2"
  if (( a <= b )); then
    echo "$a"
  else
    echo "$b"
  fi
}
