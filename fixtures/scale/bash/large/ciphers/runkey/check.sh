# Round-trip verification for the runkey cipher.

source ./ciphers/runkey/cipher.sh

runkey_verify() {
  local sample="$1" enc dec
  enc=$(runkey_encrypt "$sample")
  dec=$(runkey_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

runkey_verify_label() {
  echo "verify:runkey"
}
