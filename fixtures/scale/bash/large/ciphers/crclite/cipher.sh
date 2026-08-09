# CrcLite: shift-xor checksum.

crclite_digest() {
  local text="$1" i v
  local h=4294967295
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    h=$(( ( (h >> 1) ^ ( (h & 1) * 3988292384 ) ^ v ) & 4294967295 ))
  done
  echo "$h"
}

crclite_hex() {
  printf '%08x' "$(crclite_digest "$1")"
}
