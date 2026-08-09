# Round-trip verification for the stride cipher.

source ./ciphers/stride/cipher.sh

stride_verify() {
  local sample="$1" enc dec
  enc=$(stride_encrypt "$sample")
  dec=$(stride_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

stride_verify_label() {
  echo "verify:stride"
}
