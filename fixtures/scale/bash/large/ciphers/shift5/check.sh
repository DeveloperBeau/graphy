# Round-trip verification for the shift5 cipher.

source ./ciphers/shift5/cipher.sh

shift5_verify() {
  local sample="$1" enc dec
  enc=$(shift5_encrypt "$sample")
  dec=$(shift5_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

shift5_verify_label() {
  echo "verify:shift5"
}
