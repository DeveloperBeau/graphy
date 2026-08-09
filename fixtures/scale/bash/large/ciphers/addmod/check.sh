# Round-trip verification for the addmod cipher.

source ./ciphers/addmod/cipher.sh

addmod_verify() {
  local sample="$1" enc dec
  enc=$(addmod_encrypt "$sample")
  dec=$(addmod_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

addmod_verify_label() {
  echo "verify:addmod"
}
