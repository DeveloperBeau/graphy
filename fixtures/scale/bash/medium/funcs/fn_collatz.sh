# Collatz step count.

calc_collatz() {
  local n="$1" steps=0
  while (( n > 1 )); do
    if (( n % 2 == 0 )); then
      n=$(( n / 2 ))
    else
      n=$(( 3 * n + 1 ))
    fi
    steps=$(( steps + 1 ))
  done
  echo "$steps"
}
