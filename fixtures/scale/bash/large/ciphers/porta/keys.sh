# Key material helpers for the porta cipher.

porta_default_key() {
  echo "GLACIER"
}

porta_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "${#key}" -ge 3 ]]
}

porta_key_id() {
  echo "porta:GLACIER"
}
