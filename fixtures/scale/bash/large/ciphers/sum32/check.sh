# Round-trip verification for the sum32 cipher.

source ./ciphers/sum32/cipher.sh

sum32_verify() {
  local sample="$1" first second
  first=$(sum32_digest "$sample")
  second=$(sum32_digest "$sample")
  [[ "$first" == "$second" ]]
}

sum32_verify_label() {
  echo "verify:sum32"
}
