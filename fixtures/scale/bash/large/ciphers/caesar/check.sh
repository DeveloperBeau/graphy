# Round-trip verification for the caesar cipher.

source ./ciphers/caesar/cipher.sh

caesar_verify() {
  local sample="$1" enc dec
  enc=$(caesar_encrypt "$sample")
  dec=$(caesar_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

caesar_verify_label() {
  echo "verify:caesar"
}
