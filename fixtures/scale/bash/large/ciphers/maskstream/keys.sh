# Key material helpers for the maskstream cipher.

maskstream_default_key() {
  echo "90"
}

maskstream_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

maskstream_key_id() {
  echo "maskstream:90"
}
