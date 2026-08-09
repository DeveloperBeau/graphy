# Round-trip verification for the fnv1a cipher.

source ./ciphers/fnv1a/cipher.sh

fnv1a_verify() {
  local sample="$1" first second
  first=$(fnv1a_digest "$sample")
  second=$(fnv1a_digest "$sample")
  [[ "$first" == "$second" ]]
}

fnv1a_verify_label() {
  echo "verify:fnv1a"
}
