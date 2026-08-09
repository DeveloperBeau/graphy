# Sum32: multiply-accumulate digest (x1).

sum32_digest() {
  local text="$1" i v
  local h=0
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    h=$(( (h * 1 + v) & 4294967295 ))
  done
  echo "$h"
}

sum32_hex() {
  printf '%08x' "$(sum32_digest "$1")"
}
