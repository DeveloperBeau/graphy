# Key material helpers for the xorroll cipher.

xorroll_default_key() {
  echo "193"
}

xorroll_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

xorroll_key_id() {
  echo "xorroll:193"
}
