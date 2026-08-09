# Integer square root (Newton).

calc_isqrt() {
  local n="$1" x g
  (( n < 2 )) && { echo "$n"; return; }
  x=$(( n / 2 ))
  while g=$(( (x + n / x) / 2 )); (( g < x )); do
    x=$g
  done
  echo "$x"
}
