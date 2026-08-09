# Round-trip verification for the railfence cipher.

source ./ciphers/railfence/cipher.sh

railfence_verify() {
  local sample="$1" enc dec
  enc=$(railfence_encrypt "$sample")
  dec=$(railfence_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

railfence_verify_label() {
  echo "verify:railfence"
}
