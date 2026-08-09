# Djb2: multiply-accumulate digest (x33).

djb2_digest() {
  local text="$1" i v
  local h=5381
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    h=$(( (h * 33 + v) & 4294967295 ))
  done
  echo "$h"
}

djb2_hex() {
  printf '%08x' "$(djb2_digest "$1")"
}
