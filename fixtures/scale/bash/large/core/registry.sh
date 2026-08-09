# Names of every registered cipher, in run order.

declare -a CIPHER_NAMES=()

register_cipher() {
  CIPHER_NAMES+=("$1")
}

registered_count() {
  echo "${#CIPHER_NAMES[@]}"
}

registry_contains() {
  local name
  for name in "${CIPHER_NAMES[@]}"; do
    [[ "$name" == "$1" ]] && return 0
  done
  return 1
}
