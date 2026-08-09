# Median of three values.

calc_med3() {
  local a="$1" b="$2" c="$3" lo hi
  lo=$(calc_imin "$a" "$b")
  hi=$(calc_imax "$a" "$b")
  if (( c < lo )); then
    echo "$lo"
  elif (( c > hi )); then
    echo "$hi"
  else
    echo "$c"
  fi
}
