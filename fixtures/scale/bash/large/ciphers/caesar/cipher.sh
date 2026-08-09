# Caesar cipher: fixed +3 byte rotation.

caesar_encrypt() {
  local text="$1" out="" i v
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    v=$(( (v + 3) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

caesar_decrypt() {
  local text="$1" out="" i v
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    v=$(( (v + 253) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}
