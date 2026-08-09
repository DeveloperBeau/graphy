# Round-trip verification for the xorroll cipher.

source ./ciphers/xorroll/cipher.sh

xorroll_verify() {
  local sample="$1" enc dec
  enc=$(xorroll_encrypt "$sample")
  dec=$(xorroll_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

xorroll_verify_label() {
  echo "verify:xorroll"
}
