# Key material helpers for the fnv1a cipher.

fnv1a_default_key() {
  echo "2166136261"
}

fnv1a_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

fnv1a_key_id() {
  echo "fnv1a:2166136261"
}
