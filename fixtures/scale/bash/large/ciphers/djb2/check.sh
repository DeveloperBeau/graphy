# Round-trip verification for the djb2 cipher.

source ./ciphers/djb2/cipher.sh

djb2_verify() {
  local sample="$1" first second
  first=$(djb2_digest "$sample")
  second=$(djb2_digest "$sample")
  [[ "$first" == "$second" ]]
}

djb2_verify_label() {
  echo "verify:djb2"
}
