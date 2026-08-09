# Key material helpers for the rothash cipher.

rothash_default_key() {
  echo "99991"
}

rothash_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

rothash_key_id() {
  echo "rothash:99991"
}
