# Modular exponentiation.

calc_modexp() {
  local base="$1" exp="$2" mod="$3" acc=1
  base=$(( base % mod ))
  while (( exp > 0 )); do
    (( exp % 2 == 1 )) && acc=$(( acc * base % mod ))
    exp=$(( exp / 2 ))
    base=$(( base * base % mod ))
  done
  echo "$acc"
}
