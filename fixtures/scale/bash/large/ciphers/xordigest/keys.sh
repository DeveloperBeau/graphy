# Key material helpers for the xordigest cipher.

xordigest_default_key() {
  echo "0"
}

xordigest_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

xordigest_key_id() {
  echo "xordigest:0"
}
