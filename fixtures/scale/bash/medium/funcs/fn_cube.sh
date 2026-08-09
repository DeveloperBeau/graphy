# Cube.

calc_cube() {
  local n="$1"
  if [[ -z "$n" ]]; then
    echo 0
    return
  fi
  echo $(( n * n * n ))
}
