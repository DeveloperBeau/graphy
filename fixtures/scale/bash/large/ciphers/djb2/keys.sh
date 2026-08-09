# Key material helpers for the djb2 cipher.

djb2_default_key() {
  echo "5381"
}

djb2_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

djb2_key_id() {
  echo "djb2:5381"
}
