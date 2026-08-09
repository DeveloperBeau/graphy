# Key material helpers for the adler cipher.

adler_default_key() {
  echo "0"
}

adler_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

adler_key_id() {
  echo "adler:0"
}
