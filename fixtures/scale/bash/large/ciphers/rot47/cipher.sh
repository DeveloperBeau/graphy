# Rot47 cipher: fixed +47 byte rotation.

rot47_encrypt() {
  local text="$1" out="" i v
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    v=$(( (v + 47) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

rot47_decrypt() {
  local text="$1" out="" i v
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    v=$(( (v + 209) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}
