# Registry of callable library functions.

declare -a CALC_FN_NAMES=()

registry_add() {
  CALC_FN_NAMES+=("$1")
}

registry_contains() {
  local name
  for name in "${CALC_FN_NAMES[@]}"; do
    [[ "$name" == "$1" ]] && return 0
  done
  return 1
}

registry_size() {
  echo "${#CALC_FN_NAMES[@]}"
}
