# Round-trip verification for the zigzag cipher.

source ./ciphers/zigzag/cipher.sh

zigzag_verify() {
  local sample="$1" enc dec
  enc=$(zigzag_encrypt "$sample")
  dec=$(zigzag_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

zigzag_verify_label() {
  echo "verify:zigzag"
}
