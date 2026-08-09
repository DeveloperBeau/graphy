# Key material helpers for the sdbm cipher.

sdbm_default_key() {
  echo "0"
}

sdbm_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

sdbm_key_id() {
  echo "sdbm:0"
}
