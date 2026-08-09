# Expression evaluation entry points.

apply_op() {
  local op="$1" a="$2" b="$3"
  case "$op" in
    +) echo $(( a + b )) ;;
    -) echo $(( a - b )) ;;
    '*') echo $(( a * b )) ;;
    /) (( b == 0 )) && { err_set "divide by zero"; return 1; }
       echo $(( a / b )) ;;
    %) echo $(( a % b )) ;;
    *) err_set "unknown operator $op"; return 1 ;;
  esac
}

eval_expr() {
  local expr="$1" tokens
  tokens=$(scan_expr "$expr") || return 1
  parse_expr "$tokens"
}
