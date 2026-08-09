# Triangular number.

calc_tri() {
  local n="$1"
  if (( n < 0 )); then
    echo 0
    return
  fi
  echo $(( n * (n + 1) / 2 ))
}
