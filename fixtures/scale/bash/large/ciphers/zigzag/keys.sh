# Key material helpers for the zigzag cipher.

zigzag_default_key() {
  echo "2"
}

zigzag_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

zigzag_key_id() {
  echo "zigzag:2"
}
