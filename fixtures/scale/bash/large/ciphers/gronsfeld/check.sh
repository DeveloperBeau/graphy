# Round-trip verification for the gronsfeld cipher.

source ./ciphers/gronsfeld/cipher.sh

gronsfeld_verify() {
  local sample="$1" enc dec
  enc=$(gronsfeld_encrypt "$sample")
  dec=$(gronsfeld_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

gronsfeld_verify_label() {
  echo "verify:gronsfeld"
}
