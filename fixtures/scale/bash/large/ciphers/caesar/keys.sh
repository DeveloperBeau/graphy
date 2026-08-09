# Key material helpers for the caesar cipher.

caesar_default_key() {
  echo "3"
}

caesar_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

caesar_key_id() {
  echo "caesar:3"
}
