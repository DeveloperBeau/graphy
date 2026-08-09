# RotHash: rotate-xor digest.

rothash_digest() {
  local text="$1" i v
  local h=99991
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    h=$(( ( ((h << 5) | (h >> 27)) ^ v ) & 4294967295 ))
  done
  echo "$h"
}

rothash_hex() {
  printf '%08x' "$(rothash_digest "$1")"
}
