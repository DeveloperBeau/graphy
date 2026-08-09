# Binomial coefficient.

calc_ncr() {
  local n="$1" r="$2" acc=1 i
  (( r > n - r )) && r=$(( n - r ))
  for (( i = 1; i <= r; i++ )); do
    acc=$(( acc * (n - r + i) / i ))
  done
  echo "$acc"
}
