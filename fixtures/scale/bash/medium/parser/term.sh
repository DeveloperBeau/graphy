# Multiplicative term parsing.

parse_term_tail() {
  local acc="$1" op="$2" rhs="$3"
  apply_op "$op" "$acc" "$rhs"
}

parse_term() {
  local tokens="$1" acc rest
  acc=$(parse_factor "$tokens")
  rest="${tokens#* }"
  while [[ "$rest" == 'OP:*'* || "$rest" == OP:/* ]]; do
    acc=$(parse_term_tail "$acc" "${rest:3:1}" "$(parse_factor "${rest#* }")")
    rest="${rest#* }"
    rest="${rest#* }"
  done
  echo "$acc"
}
