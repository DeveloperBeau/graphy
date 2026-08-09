# Key material helpers for the feistel cipher.

feistel_default_key() {
  echo "101"
}

feistel_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

feistel_key_id() {
  echo "feistel:101"
}
