# Fnv1a: xor-then-multiply digest.

fnv1a_digest() {
  local text="$1" i v
  local h=2166136261
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    h=$(( ( (h ^ v) * 16777619 ) & 4294967295 ))
  done
  echo "$h"
}

fnv1a_hex() {
  printf '%08x' "$(fnv1a_digest "$1")"
}
