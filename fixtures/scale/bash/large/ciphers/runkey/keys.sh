# Key material helpers for the runkey cipher.

runkey_default_key() {
  echo "THEQUICKBROWNFOX"
}

runkey_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "${#key}" -ge 3 ]]
}

runkey_key_id() {
  echo "runkey:THEQUICKBROWNFOX"
}
