# Trithemius cipher: repeating key "ABC" mixed into the byte stream.

TRITHEMIUS_KEY="ABC"

trithemius_encrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#TRITHEMIUS_KEY} ))
    printf -v k '%d' "'${TRITHEMIUS_KEY:ki:1}"
    v=$(( (v + k + i) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

trithemius_decrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#TRITHEMIUS_KEY} ))
    printf -v k '%d' "'${TRITHEMIUS_KEY:ki:1}"
    v=$(( (v + 512 - k - (i % 256)) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}
