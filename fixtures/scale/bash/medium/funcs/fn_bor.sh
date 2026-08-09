# Bitwise or.

calc_bor() {
  local a="$1" b="$2"
  if [[ -z "$b" ]]; then
    echo "$a"
    return
  fi
  echo $(( a | b ))
}
