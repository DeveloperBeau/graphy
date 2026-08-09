# Key material helpers for the rc4lite cipher.

rc4lite_default_key() {
  echo "17"
}

rc4lite_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

rc4lite_key_id() {
  echo "rc4lite:17"
}
