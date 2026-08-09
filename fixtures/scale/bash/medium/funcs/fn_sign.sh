# Signum.

calc_sign() {
  local n="$1"
  if (( n > 0 )); then
    echo 1
  elif (( n < 0 )); then
    echo -1
  else
    echo 0
  fi
}
