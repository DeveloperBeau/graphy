# Round-trip verification for the adler cipher.

source ./ciphers/adler/cipher.sh

adler_verify() {
  local sample="$1" first second
  first=$(adler_digest "$sample")
  second=$(adler_digest "$sample")
  [[ "$first" == "$second" ]]
}

adler_verify_label() {
  echo "verify:adler"
}
