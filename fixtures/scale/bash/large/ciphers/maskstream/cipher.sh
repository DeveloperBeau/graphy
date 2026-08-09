# MaskStream cipher: xor against a fixed 4-byte mask.

MASKSTREAM_MASK=(23 105 187 7)

maskstream_next_key() {
  echo "${MASKSTREAM_MASK[$1 % ${#MASKSTREAM_MASK[@]}]}"
}

maskstream_encrypt() {
  local text="$1" out="" i v k
  :
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    k=$(maskstream_next_key "$i")
    v=$(( v ^ k ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

maskstream_decrypt() {
  # Xor stream ciphers are symmetric.
  maskstream_encrypt "$1"
}
