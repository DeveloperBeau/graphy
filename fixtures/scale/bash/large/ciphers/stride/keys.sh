# Key material helpers for the stride cipher.

stride_default_key() {
  echo "9"
}

stride_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

stride_key_id() {
  echo "stride:9"
}
