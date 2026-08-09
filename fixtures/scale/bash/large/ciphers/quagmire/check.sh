# Round-trip verification for the quagmire cipher.

source ./ciphers/quagmire/cipher.sh

quagmire_verify() {
  local sample="$1" enc dec
  enc=$(quagmire_encrypt "$sample")
  dec=$(quagmire_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

quagmire_verify_label() {
  echo "verify:quagmire"
}
