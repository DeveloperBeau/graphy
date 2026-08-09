# Round-trip verification for the rc4lite cipher.

source ./ciphers/rc4lite/cipher.sh

rc4lite_verify() {
  local sample="$1" enc dec
  enc=$(rc4lite_encrypt "$sample")
  dec=$(rc4lite_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

rc4lite_verify_label() {
  echo "verify:rc4lite"
}
