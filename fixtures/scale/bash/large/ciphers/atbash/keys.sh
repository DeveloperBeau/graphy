# Key material helpers for the atbash cipher.

atbash_default_key() {
  echo "3"
}

atbash_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

atbash_key_id() {
  echo "atbash:3"
}
