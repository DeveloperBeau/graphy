# Key material helpers for the blockswap cipher.

blockswap_default_key() {
  echo "8"
}

blockswap_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

blockswap_key_id() {
  echo "blockswap:8"
}
