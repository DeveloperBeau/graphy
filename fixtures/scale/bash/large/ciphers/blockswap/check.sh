# Round-trip verification for the blockswap cipher.

source ./ciphers/blockswap/cipher.sh

blockswap_verify() {
  local sample="$1" enc dec
  enc=$(blockswap_encrypt "$sample")
  dec=$(blockswap_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

blockswap_verify_label() {
  echo "verify:blockswap"
}
