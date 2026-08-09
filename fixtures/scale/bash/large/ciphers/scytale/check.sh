# Round-trip verification for the scytale cipher.

source ./ciphers/scytale/cipher.sh

scytale_verify() {
  local sample="$1" enc dec
  enc=$(scytale_encrypt "$sample")
  dec=$(scytale_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

scytale_verify_label() {
  echo "verify:scytale"
}
