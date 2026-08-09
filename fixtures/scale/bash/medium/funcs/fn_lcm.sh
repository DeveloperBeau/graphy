# Least common multiple via gcd.

calc_lcm() {
  local a="$1" b="$2" g
  if (( a == 0 || b == 0 )); then
    echo 0
    return
  fi
  g=$(calc_gcd "$a" "$b")
  echo $(( a / g * b ))
}
