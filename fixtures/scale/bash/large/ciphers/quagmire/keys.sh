# Key material helpers for the quagmire cipher.

quagmire_default_key() {
  echo "OCEAN"
}

quagmire_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "${#key}" -ge 3 ]]
}

quagmire_key_id() {
  echo "quagmire:OCEAN"
}
