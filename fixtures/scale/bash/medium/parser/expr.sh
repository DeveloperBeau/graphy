# Additive expression parsing over the token stream.

parse_expr_tail() {
  local acc="$1" op="$2" rhs="$3"
  apply_op "$op" "$acc" "$rhs"
}

parse_expr() {
  local tokens="$1" acc rest
  acc=$(parse_term "$tokens")
  rest="${tokens#* }"
  while [[ "$rest" == OP:+* || "$rest" == OP:-* ]]; do
    acc=$(parse_expr_tail "$acc" "${rest:3:1}" "$(parse_term "${rest#* }")")
    rest="${rest#* }"
    rest="${rest#* }"
  done
  echo "$acc"
}
