# Key material helpers for the prodhash cipher.

prodhash_default_key() {
  echo "7"
}

prodhash_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

prodhash_key_id() {
  echo "prodhash:7"
}
