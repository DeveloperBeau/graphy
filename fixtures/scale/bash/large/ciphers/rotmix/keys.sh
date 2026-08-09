# Key material helpers for the rotmix cipher.

rotmix_default_key() {
  echo "3"
}

rotmix_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

rotmix_key_id() {
  echo "rotmix:3"
}
