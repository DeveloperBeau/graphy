# Round-trip verification for the decimation cipher.

source ./ciphers/decimation/cipher.sh

decimation_verify() {
  local sample="$1" enc dec
  enc=$(decimation_encrypt "$sample")
  dec=$(decimation_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

decimation_verify_label() {
  echo "verify:decimation"
}
