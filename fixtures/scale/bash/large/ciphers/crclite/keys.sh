# Key material helpers for the crclite cipher.

crclite_default_key() {
  echo "4294967295"
}

crclite_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

crclite_key_id() {
  echo "crclite:4294967295"
}
