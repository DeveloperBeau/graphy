# ProdHash: multiply-accumulate digest (x31).

prodhash_digest() {
  local text="$1" i v
  local h=7
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    h=$(( (h * 31 + v) & 4294967295 ))
  done
  echo "$h"
}

prodhash_hex() {
  printf '%08x' "$(prodhash_digest "$1")"
}
