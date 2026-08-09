# Round-trip verification for the cbcxor cipher.

source ./ciphers/cbcxor/cipher.sh

cbcxor_verify() {
  local sample="$1" enc dec
  enc=$(cbcxor_encrypt "$sample")
  dec=$(cbcxor_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

cbcxor_verify_label() {
  echo "verify:cbcxor"
}
