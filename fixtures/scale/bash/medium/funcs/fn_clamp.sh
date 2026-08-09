# Clamp a value into [lo, hi].

calc_clamp() {
  local v="$1" lo="$2" hi="$3"
  if (( lo > hi )); then
    echo "$v"
    return 1
  fi
  (( v < lo )) && v=$lo
  (( v > hi )) && v=$hi
  echo "$v"
}
