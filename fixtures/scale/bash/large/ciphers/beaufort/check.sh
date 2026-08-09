# Round-trip verification for the beaufort cipher.

source ./ciphers/beaufort/cipher.sh

beaufort_verify() {
  local sample="$1" enc dec
  enc=$(beaufort_encrypt "$sample")
  dec=$(beaufort_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

beaufort_verify_label() {
  echo "verify:beaufort"
}
