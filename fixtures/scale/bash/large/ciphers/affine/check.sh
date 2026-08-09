# Round-trip verification for the affine cipher.

source ./ciphers/affine/cipher.sh

affine_verify() {
  local sample="$1" enc dec
  enc=$(affine_encrypt "$sample")
  dec=$(affine_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

affine_verify_label() {
  echo "verify:affine"
}
