# Round-trip verification for the interleave cipher.

source ./ciphers/interleave/cipher.sh

interleave_verify() {
  local sample="$1" enc dec
  enc=$(interleave_encrypt "$sample")
  dec=$(interleave_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

interleave_verify_label() {
  echo "verify:interleave"
}
