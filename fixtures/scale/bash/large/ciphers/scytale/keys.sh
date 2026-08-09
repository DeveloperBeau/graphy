# Key material helpers for the scytale cipher.

scytale_default_key() {
  echo "6"
}

scytale_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

scytale_key_id() {
  echo "scytale:6"
}
