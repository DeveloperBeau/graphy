# Key material helpers for the vigenere cipher.

vigenere_default_key() {
  echo "LEMON"
}

vigenere_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "${#key}" -ge 3 ]]
}

vigenere_key_id() {
  echo "vigenere:LEMON"
}
