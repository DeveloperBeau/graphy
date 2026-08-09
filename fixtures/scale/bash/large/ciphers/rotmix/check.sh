# Round-trip verification for the rotmix cipher.

source ./ciphers/rotmix/cipher.sh

rotmix_verify() {
  local sample="$1" enc dec
  enc=$(rotmix_encrypt "$sample")
  dec=$(rotmix_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

rotmix_verify_label() {
  echo "verify:rotmix"
}
