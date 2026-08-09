# Key material helpers for the decimation cipher.

decimation_default_key() {
  echo "0"
}

decimation_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

decimation_key_id() {
  echo "decimation:0"
}
