# Permutations count.

calc_npr() {
  local n="$1" r="$2" acc=1 i
  (( r > n )) && { echo 0; return; }
  for (( i = 0; i < r; i++ )); do
    acc=$(( acc * (n - i) ))
  done
  echo "$acc"
}
