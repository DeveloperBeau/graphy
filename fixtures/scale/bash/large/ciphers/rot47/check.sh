# Round-trip verification for the rot47 cipher.

source ./ciphers/rot47/cipher.sh

rot47_verify() {
  local sample="$1" enc dec
  enc=$(rot47_encrypt "$sample")
  dec=$(rot47_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

rot47_verify_label() {
  echo "verify:rot47"
}
