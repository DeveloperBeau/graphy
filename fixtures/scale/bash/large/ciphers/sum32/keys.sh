# Key material helpers for the sum32 cipher.

sum32_default_key() {
  echo "0"
}

sum32_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

sum32_key_id() {
  echo "sum32:0"
}
