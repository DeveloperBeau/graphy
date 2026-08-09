# Digital root.

calc_digroot() {
  local n="${1#-}"
  if (( n == 0 )); then
    echo 0
    return
  fi
  echo $(( 1 + (n - 1) % 9 ))
}
