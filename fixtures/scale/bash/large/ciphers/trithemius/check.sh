# Round-trip verification for the trithemius cipher.

source ./ciphers/trithemius/cipher.sh

trithemius_verify() {
  local sample="$1" enc dec
  enc=$(trithemius_encrypt "$sample")
  dec=$(trithemius_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

trithemius_verify_label() {
  echo "verify:trithemius"
}
