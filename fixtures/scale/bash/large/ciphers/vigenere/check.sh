# Round-trip verification for the vigenere cipher.

source ./ciphers/vigenere/cipher.sh

vigenere_verify() {
  local sample="$1" enc dec
  enc=$(vigenere_encrypt "$sample")
  dec=$(vigenere_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

vigenere_verify_label() {
  echo "verify:vigenere"
}
