# Key material helpers for the shift5 cipher.

shift5_default_key() {
  echo "5"
}

shift5_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

shift5_key_id() {
  echo "shift5:5"
}
