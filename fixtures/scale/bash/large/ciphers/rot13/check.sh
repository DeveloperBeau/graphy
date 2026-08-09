# Round-trip verification for the rot13 cipher.

source ./ciphers/rot13/cipher.sh

rot13_verify() {
  local sample="$1" enc dec
  enc=$(rot13_encrypt "$sample")
  dec=$(rot13_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

rot13_verify_label() {
  echo "verify:rot13"
}
