# Round-trip verification for the sdbm cipher.

source ./ciphers/sdbm/cipher.sh

sdbm_verify() {
  local sample="$1" first second
  first=$(sdbm_digest "$sample")
  second=$(sdbm_digest "$sample")
  [[ "$first" == "$second" ]]
}

sdbm_verify_label() {
  echo "verify:sdbm"
}
