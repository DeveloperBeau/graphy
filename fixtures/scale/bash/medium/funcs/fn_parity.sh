# Population-count parity.

calc_parity() {
  local n="$1" p=0
  while (( n > 0 )); do
    p=$(( p ^ (n & 1) ))
    n=$(( n >> 1 ))
  done
  echo "$p"
}
