# Sdbm: multiply-accumulate digest (x65599).

sdbm_digest() {
  local text="$1" i v
  local h=0
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    h=$(( (h * 65599 + v) & 4294967295 ))
  done
  echo "$h"
}

sdbm_hex() {
  printf '%08x' "$(sdbm_digest "$1")"
}
