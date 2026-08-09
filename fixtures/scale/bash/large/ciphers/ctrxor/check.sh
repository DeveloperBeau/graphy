# Round-trip verification for the ctrxor cipher.

source ./ciphers/ctrxor/cipher.sh

ctrxor_verify() {
  local sample="$1" enc dec
  enc=$(ctrxor_encrypt "$sample")
  dec=$(ctrxor_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

ctrxor_verify_label() {
  echo "verify:ctrxor"
}
