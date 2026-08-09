# Round-trip verification for the feistel cipher.

source ./ciphers/feistel/cipher.sh

feistel_verify() {
  local sample="$1" enc dec
  enc=$(feistel_encrypt "$sample")
  dec=$(feistel_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

feistel_verify_label() {
  echo "verify:feistel"
}
