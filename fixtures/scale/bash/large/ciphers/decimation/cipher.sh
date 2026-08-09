# Decimation cipher: affine map 7x+0 over bytes.

decimation_encrypt() {
  local text="$1" out="" i v
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    v=$(( (7 * v + 0) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

decimation_decrypt() {
  local text="$1" out="" i v
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    v=$(( (183 * (v + 256 - 0)) % 256 ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}
