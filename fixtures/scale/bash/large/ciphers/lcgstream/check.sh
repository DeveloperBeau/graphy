# Round-trip verification for the lcgstream cipher.

source ./ciphers/lcgstream/cipher.sh

lcgstream_verify() {
  local sample="$1" enc dec
  enc=$(lcgstream_encrypt "$sample")
  dec=$(lcgstream_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

lcgstream_verify_label() {
  echo "verify:lcgstream"
}
