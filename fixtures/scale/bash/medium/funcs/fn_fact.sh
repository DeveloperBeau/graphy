# Factorial (iterative).

calc_fact() {
  local n="$1" acc=1 i
  (( n < 0 )) && { echo 0; return 1; }
  for (( i = 2; i <= n; i++ )); do
    acc=$(( acc * i ))
  done
  echo "$acc"
}
