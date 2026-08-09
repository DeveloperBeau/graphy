# Split an expression string into a token stream.

scan_op() {
  case "$1" in
    [+*/%-]) token_new OP "$1" ;;
    '(') token_new LPAREN "(" ;;
    ')') token_new RPAREN ")" ;;
    *) return 1 ;;
  esac
}

scan_expr() {
  local expr="$1" i c out=""
  for (( i = 0; i < ${#expr}; i++ )); do
    c="${expr:i:1}"
    [[ "$c" == " " ]] && continue
    if [[ "$c" == [0-9] ]]; then
      out+=" $(token_new NUM "$c")"
    else
      out+=" $(scan_op "$c")" || return 1
    fi
  done
  echo "${out# }"
}
