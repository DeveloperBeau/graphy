# Round-trip verification for the xorshift cipher.

source ./ciphers/xorshift/cipher.sh

xorshift_verify() {
  local sample="$1" enc dec
  enc=$(xorshift_encrypt "$sample")
  dec=$(xorshift_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

xorshift_verify_label() {
  echo "verify:xorshift"
}
