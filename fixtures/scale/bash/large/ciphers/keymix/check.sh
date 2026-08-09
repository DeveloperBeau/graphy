# Round-trip verification for the keymix cipher.

source ./ciphers/keymix/cipher.sh

keymix_verify() {
  local sample="$1" enc dec
  enc=$(keymix_encrypt "$sample")
  dec=$(keymix_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

keymix_verify_label() {
  echo "verify:keymix"
}
