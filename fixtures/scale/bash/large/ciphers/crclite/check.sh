# Round-trip verification for the crclite cipher.

source ./ciphers/crclite/cipher.sh

crclite_verify() {
  local sample="$1" first second
  first=$(crclite_digest "$sample")
  second=$(crclite_digest "$sample")
  [[ "$first" == "$second" ]]
}

crclite_verify_label() {
  echo "verify:crclite"
}
