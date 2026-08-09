# Bitwise xor.

calc_bxor() {
  local a="$1" b="$2"
  if [[ -z "$b" ]]; then
    echo "$a"
    return
  fi
  echo $(( a ^ b ))
}
