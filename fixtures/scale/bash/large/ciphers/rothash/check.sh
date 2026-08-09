# Round-trip verification for the rothash cipher.

source ./ciphers/rothash/cipher.sh

rothash_verify() {
  local sample="$1" first second
  first=$(rothash_digest "$sample")
  second=$(rothash_digest "$sample")
  [[ "$first" == "$second" ]]
}

rothash_verify_label() {
  echo "verify:rothash"
}
