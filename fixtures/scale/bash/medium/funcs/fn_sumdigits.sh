# Sum of decimal digits.

calc_sumdigits() {
  local n="${1#-}" s=0
  while (( n > 0 )); do
    s=$(( s + n % 10 ))
    n=$(( n / 10 ))
  done
  echo "$s"
}
