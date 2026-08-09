# Key material helpers for the addmod cipher.

addmod_default_key() {
  echo "17"
}

addmod_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

addmod_key_id() {
  echo "addmod:17"
}
