# Keymix cipher: repeating key "ZEBRA" mixed into the byte stream.

KEYMIX_KEY="ZEBRA"

keymix_encrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#KEYMIX_KEY} ))
    printf -v k '%d' "'${KEYMIX_KEY:ki:1}"
    v=$(( (v + k + 7) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

keymix_decrypt() {
  local text="$1" out="" i v k ki
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    ki=$(( i % ${#KEYMIX_KEY} ))
    printf -v k '%d' "'${KEYMIX_KEY:ki:1}"
    v=$(( (v + 512 - k - 7) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}
