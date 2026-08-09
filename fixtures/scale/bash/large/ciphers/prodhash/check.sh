# Round-trip verification for the prodhash cipher.

source ./ciphers/prodhash/cipher.sh

prodhash_verify() {
  local sample="$1" first second
  first=$(prodhash_digest "$sample")
  second=$(prodhash_digest "$sample")
  [[ "$first" == "$second" ]]
}

prodhash_verify_label() {
  echo "verify:prodhash"
}
