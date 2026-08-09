# Key material helpers for the xorbasic cipher.

xorbasic_default_key() {
  echo "90"
}

xorbasic_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

xorbasic_key_id() {
  echo "xorbasic:90"
}
