# Bitwise and.

calc_band() {
  local a="$1" b="$2"
  if [[ -z "$b" ]]; then
    echo 0
    return
  fi
  echo $(( a & b ))
}
