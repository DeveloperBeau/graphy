# Key material helpers for the rot47 cipher.

rot47_default_key() {
  echo "47"
}

rot47_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

rot47_key_id() {
  echo "rot47:47"
}
