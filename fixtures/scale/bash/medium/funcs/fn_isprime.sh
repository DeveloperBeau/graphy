# Primality by trial division.

isprime_trial() {
  local n="$1" d
  for (( d = 3; d * d <= n; d += 2 )); do
    (( n % d == 0 )) && return 1
  done
  return 0
}

calc_isprime() {
  local n="$1"
  (( n < 2 )) && { echo 0; return; }
  (( n == 2 )) && { echo 1; return; }
  (( n % 2 == 0 )) && { echo 0; return; }
  if isprime_trial "$n"; then echo 1; else echo 0; fi
}
