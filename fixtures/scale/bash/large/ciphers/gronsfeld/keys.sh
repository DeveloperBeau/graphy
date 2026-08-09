# Key material helpers for the gronsfeld cipher.

gronsfeld_default_key() {
  echo "31415"
}

gronsfeld_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "${#key}" -ge 3 ]]
}

gronsfeld_key_id() {
  echo "gronsfeld:31415"
}
