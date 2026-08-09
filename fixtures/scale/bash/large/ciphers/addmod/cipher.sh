# Addmod cipher: fixed +17 byte rotation.

addmod_encrypt() {
  local text="$1" out="" i v
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    v=$(( (v + 17) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

addmod_decrypt() {
  local text="$1" out="" i v
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    v=$(( (v + 239) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}
