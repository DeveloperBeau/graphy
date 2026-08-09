# Key material helpers for the revblocks cipher.

revblocks_default_key() {
  echo "4"
}

revblocks_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

revblocks_key_id() {
  echo "revblocks:4"
}
