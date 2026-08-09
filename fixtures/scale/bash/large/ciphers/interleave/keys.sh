# Key material helpers for the interleave cipher.

interleave_default_key() {
  echo "8"
}

interleave_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

interleave_key_id() {
  echo "interleave:8"
}
