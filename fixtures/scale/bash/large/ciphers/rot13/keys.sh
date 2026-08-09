# Key material helpers for the rot13 cipher.

rot13_default_key() {
  echo "13"
}

rot13_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

rot13_key_id() {
  echo "rot13:13"
}
