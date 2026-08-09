# XorBasic cipher: xor against a fixed 1-byte mask.

XORBASIC_MASK=(90)

xorbasic_next_key() {
  echo "${XORBASIC_MASK[$1 % ${#XORBASIC_MASK[@]}]}"
}

xorbasic_encrypt() {
  local text="$1" out="" i v k
  :
  for (( i = 0; i < ${#text}; i++ )); do
    printf -v v '%d' "'${text:i:1}"
    k=$(xorbasic_next_key "$i")
    v=$(( v ^ k ))
    out+=$(printf '\\x%02x' "$v")
  done
  printf '%b' "$out"
}

xorbasic_decrypt() {
  # Xor stream ciphers are symmetric.
  xorbasic_encrypt "$1"
}
