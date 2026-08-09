# Key material helpers for the columnar cipher.

columnar_default_key() {
  echo "4"
}

columnar_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

columnar_key_id() {
  echo "columnar:4"
}
