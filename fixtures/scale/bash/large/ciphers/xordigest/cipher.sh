# XorDigest: position-spread xor digest.

xordigest_digest() {
  local text="$1" i v
  local h=0
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    h=$(( ( h ^ (v << ((i % 4) * 8)) ) & 4294967295 ))
  done
  echo "$h"
}

xordigest_hex() {
  printf '%08x' "$(xordigest_digest "$1")"
}
