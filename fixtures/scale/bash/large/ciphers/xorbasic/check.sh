# Round-trip verification for the xorbasic cipher.

source ./ciphers/xorbasic/cipher.sh

xorbasic_verify() {
  local sample="$1" enc dec
  enc=$(xorbasic_encrypt "$sample")
  dec=$(xorbasic_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

xorbasic_verify_label() {
  echo "verify:xorbasic"
}
