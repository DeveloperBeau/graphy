# Fibonacci number (iterative).

calc_fib() {
  local n="$1" a=0 b=1 t i
  for (( i = 0; i < n; i++ )); do
    t=$(( a + b ))
    a=$b
    b=$t
  done
  echo "$a"
}
