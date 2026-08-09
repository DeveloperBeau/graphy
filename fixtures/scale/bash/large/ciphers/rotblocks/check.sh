# Round-trip verification for the rotblocks cipher.

source ./ciphers/rotblocks/cipher.sh

rotblocks_verify() {
  local sample="$1" enc dec
  enc=$(rotblocks_encrypt "$sample")
  dec=$(rotblocks_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

rotblocks_verify_label() {
  echo "verify:rotblocks"
}
