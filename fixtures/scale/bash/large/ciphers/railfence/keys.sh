# Key material helpers for the railfence cipher.

railfence_default_key() {
  echo "6"
}

railfence_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

railfence_key_id() {
  echo "railfence:6"
}
