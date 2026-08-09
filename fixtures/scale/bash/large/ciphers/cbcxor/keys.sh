# Key material helpers for the cbcxor cipher.

cbcxor_default_key() {
  echo "113"
}

cbcxor_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

cbcxor_key_id() {
  echo "cbcxor:113"
}
