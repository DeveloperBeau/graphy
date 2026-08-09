# Token encoding: TYPE:VALUE strings.

token_new() {
  printf '%s:%s' "$1" "$2"
}

token_type() {
  echo "${1%%:*}"
}

token_value() {
  echo "${1#*:}"
}
