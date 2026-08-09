# Error slot shared by parser and evaluator.

CALC_ERR=""

err_set() {
  CALC_ERR="$1"
}

err_get() {
  echo "$CALC_ERR"
}

err_report() {
  [[ -n "$CALC_ERR" ]] && echo "error: $(err_get)" >&2
}
