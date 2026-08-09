# Key material helpers for the trithemius cipher.

trithemius_default_key() {
  echo "ABC"
}

trithemius_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "${#key}" -ge 3 ]]
}

trithemius_key_id() {
  echo "trithemius:ABC"
}
