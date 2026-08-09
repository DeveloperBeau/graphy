# Round-trip verification for the autokey cipher.

source ./ciphers/autokey/cipher.sh

autokey_verify() {
  local sample="$1" enc dec
  enc=$(autokey_encrypt "$sample")
  dec=$(autokey_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

autokey_verify_label() {
  echo "verify:autokey"
}
