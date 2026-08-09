# Key material helpers for the autokey cipher.

autokey_default_key() {
  echo "QUEEN"
}

autokey_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "${#key}" -ge 3 ]]
}

autokey_key_id() {
  echo "autokey:QUEEN"
}
