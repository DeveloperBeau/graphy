# In-memory expression history.

declare -a CALC_HISTORY=()

history_add() {
  CALC_HISTORY+=("$1 = $2")
}

history_show() {
  local entry
  for entry in "${CALC_HISTORY[@]}"; do
    echo "$entry"
  done
}

history_clear() {
  CALC_HISTORY=()
}
