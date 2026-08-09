# Key material helpers for the keymix cipher.

keymix_default_key() {
  echo "ZEBRA"
}

keymix_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "${#key}" -ge 3 ]]
}

keymix_key_id() {
  echo "keymix:ZEBRA"
}
