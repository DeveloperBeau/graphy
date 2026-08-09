# Round-trip verification for the atbash cipher.

source ./ciphers/atbash/cipher.sh

atbash_verify() {
  local sample="$1" enc dec
  enc=$(atbash_encrypt "$sample")
  dec=$(atbash_decrypt "$enc")
  [[ "$dec" == "$sample" ]]
}

atbash_verify_label() {
  echo "verify:atbash"
}
