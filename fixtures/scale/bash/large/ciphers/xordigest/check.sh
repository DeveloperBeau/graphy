# Round-trip verification for the xordigest cipher.

source ./ciphers/xordigest/cipher.sh

xordigest_verify() {
  local sample="$1" first second
  first=$(xordigest_digest "$sample")
  second=$(xordigest_digest "$sample")
  [[ "$first" == "$second" ]]
}

xordigest_verify_label() {
  echo "verify:xordigest"
}
