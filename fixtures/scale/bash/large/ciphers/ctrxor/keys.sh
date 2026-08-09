# Key material helpers for the ctrxor cipher.

ctrxor_default_key() {
  echo "7"
}

ctrxor_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

ctrxor_key_id() {
  echo "ctrxor:7"
}
