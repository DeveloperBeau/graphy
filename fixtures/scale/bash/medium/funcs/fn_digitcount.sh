# Number of decimal digits.

calc_digitcount() {
  local n="${1#-}" c=1
  while (( n >= 10 )); do
    n=$(( n / 10 ))
    c=$(( c + 1 ))
  done
  echo "$c"
}
