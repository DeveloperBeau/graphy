# Key material helpers for the beaufort cipher.

beaufort_default_key() {
  echo "FORTRESS"
}

beaufort_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "${#key}" -ge 3 ]]
}

beaufort_key_id() {
  echo "beaufort:FORTRESS"
}
