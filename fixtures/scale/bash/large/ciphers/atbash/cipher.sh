# Atbash cipher: mirror each byte across the range.

atbash_encrypt() {
  local text="$1" out="" i v
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    v=$(( 255 - v ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

atbash_decrypt() {
  local text="$1" out="" i v
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    v=$(( 255 - v ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}
