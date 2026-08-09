# Key material helpers for the xorshift cipher.

xorshift_default_key() {
  echo "911"
}

xorshift_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

xorshift_key_id() {
  echo "xorshift:911"
}
