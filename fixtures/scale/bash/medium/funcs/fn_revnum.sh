# Reverse decimal digits.

calc_revnum() {
  local n="${1#-}" out=0
  while (( n > 0 )); do
    out=$(( out * 10 + n % 10 ))
    n=$(( n / 10 ))
  done
  echo "$out"
}
