# Greatest common divisor (Euclid).

calc_gcd() {
  local a="${1#-}" b="${2#-}" t
  while (( b != 0 )); do
    t=$(( a % b ))
    a=$b
    b=$t
  done
  echo "$a"
}
