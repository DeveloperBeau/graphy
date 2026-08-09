# Maximum of two integers.

calc_imax() {
  local a="$1" b="$2"
  if (( a >= b )); then
    echo "$a"
  else
    echo "$b"
  fi
}
