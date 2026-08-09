# Integer exponentiation.

calc_pow() {
  local base="$1" exp="$2" acc=1 i
  (( exp < 0 )) && { echo 0; return 1; }
  for (( i = 0; i < exp; i++ )); do
    acc=$(( acc * base ))
  done
  echo "$acc"
}
