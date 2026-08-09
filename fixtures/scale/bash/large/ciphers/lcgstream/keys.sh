# Key material helpers for the lcgstream cipher.

lcgstream_default_key() {
  echo "42"
}

lcgstream_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

lcgstream_key_id() {
  echo "lcgstream:42"
}
