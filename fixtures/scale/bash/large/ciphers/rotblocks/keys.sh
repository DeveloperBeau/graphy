# Key material helpers for the rotblocks cipher.

rotblocks_default_key() {
  echo "6"
}

rotblocks_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

rotblocks_key_id() {
  echo "rotblocks:6"
}
