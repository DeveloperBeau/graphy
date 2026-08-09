# Round-trip verification for the maskstream cipher.

source ./ciphers/maskstream/cipher.sh

maskstream_verify() {
  local sample="$1" enc dec
  enc=$(maskstream_encrypt "$sample")
  dec=$(maskstream_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

maskstream_verify_label() {
  echo "verify:maskstream"
}
