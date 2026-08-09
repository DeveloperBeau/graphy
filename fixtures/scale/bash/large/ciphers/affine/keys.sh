# Key material helpers for the affine cipher.

affine_default_key() {
  echo "8"
}

affine_validate_key() {
  local key="$1"
  [[ -n "$key" ]] || return 1
  [[ "$key" =~ ^[0-9]+$ ]]
}

affine_key_id() {
  echo "affine:8"
}
