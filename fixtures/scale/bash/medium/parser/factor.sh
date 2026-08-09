# Numbers, negation and parenthesised groups.

parse_negate() {
  echo $(( -$1 ))
}

parse_factor() {
  local tok="${1%% *}" type value
  type=$(token_type "$tok")
  value=$(token_value "$tok")
  case "$type" in
    NUM) echo "$value" ;;
    OP) [[ "$value" == "-" ]] && parse_negate "$(parse_factor "${1#* }")" ;;
    LPAREN) parse_expr "${1#* }" ;;
    *) err_set "unexpected token $tok"; return 1 ;;
  esac
}
