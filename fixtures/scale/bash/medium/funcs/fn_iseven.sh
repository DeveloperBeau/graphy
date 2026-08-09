# Even predicate.

calc_iseven() {
  local n="$1"
  if (( n % 2 == 0 )); then
    echo 1
  else
    echo 0
  fi
}
