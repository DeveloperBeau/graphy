# Adler: two-accumulator checksum.

adler_digest() {
  local text="$1" i v
  local a=1 b=0
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    a=$(( (a + v) % 65521 ))
    b=$(( (b + a) % 65521 ))
  done
  echo $(( (b << 16) | a ))
}

adler_hex() {
  printf '%08x' "$(adler_digest "$1")"
}
