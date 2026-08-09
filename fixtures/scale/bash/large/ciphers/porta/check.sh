# Round-trip verification for the porta cipher.

source ./ciphers/porta/cipher.sh

porta_verify() {
  local sample="$1" enc dec
  enc=$(porta_encrypt "$sample")
  dec=$(porta_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

porta_verify_label() {
  echo "verify:porta"
}
