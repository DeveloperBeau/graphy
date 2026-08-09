# Round-trip verification for the revblocks cipher.

source ./ciphers/revblocks/cipher.sh

revblocks_verify() {
  local sample="$1" enc dec
  enc=$(revblocks_encrypt "$sample")
  dec=$(revblocks_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

revblocks_verify_label() {
  echo "verify:revblocks"
}
