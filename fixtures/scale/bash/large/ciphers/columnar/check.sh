# Round-trip verification for the columnar cipher.

source ./ciphers/columnar/cipher.sh

columnar_verify() {
  local sample="$1" enc dec
  enc=$(columnar_encrypt "$sample")
  dec=$(columnar_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

columnar_verify_label() {
  echo "verify:columnar"
}
